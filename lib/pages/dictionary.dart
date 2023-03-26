import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dictionary extends StatefulWidget {
  const Dictionary(BuildContext context, {super.key});

  @override
  State<Dictionary> createState() => _DictionaryState();
}

class _DictionaryState extends State<Dictionary> {
  final TextEditingController _controller = TextEditingController();
  String _textFieldValue = '';
  WordData wordData = WordData();
  AudioPlayer player = AudioPlayer();
  List<String> data = [];

  Future<void> fetchData(String urlEndpoint) async {
    final prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getStringList('data');
    bool newWord = true;
    if (savedData != null) {
      setState(() {
        data = savedData;
      });
    }
    print(data);
    for (var obj in data) {
      Map<String, dynamic> jsonWordData = jsonDecode(obj);
      WordData savedWordData = WordData.fromJson(jsonWordData);
      if (savedWordData.word.toUpperCase() == _textFieldValue.toUpperCase()) {
        newWord = false;
        setState(() {
          wordData = savedWordData;
        });
      }
    }
    if (newWord) {
      final apiUrl = Uri.parse(
          'https://api.dictionaryapi.dev/api/v2/entries/en/$urlEndpoint');
      final response = await http.get(apiUrl);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        setState(() {
          wordData = getDataFromResponse(jsonData);
          print(wordData);
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
        setState(() {
          wordData = WordData();
        });
      }
    }
  }

  void _saveData() async {
    setState(() {
      data.add(jsonEncode(wordData.toJson()));
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('data', data);
  }

// Map<String, dynamic> personMap = jsonDecode(personJson);
// Person decodedPerson = Person.fromJson(personMap);

  void playSound(String url) async {
    int result = await player.play(url);
    if (result == 1) {
      // success
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30),
            child: TextField(
              controller: _controller,
              style: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w400, height: 1),
              decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16.0),
                    ),
                  ),
                  hintText: 'Cooking',
                  suffixIcon: IconButton(
                      color: Colors.black,
                      onPressed: () {
                        setState(() {
                          _textFieldValue = _controller.text;
                        });
                        fetchData(_textFieldValue);
                      },
                      icon: const Icon(Icons.search))),
              onSubmitted: (value) async {
                setState(() {
                  _textFieldValue = _controller.text;
                });
                await fetchData(value);
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 90),
          child: wordData.word == ""
              ? const Text("")
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  wordData.word,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Text(
                                    wordData.phonetic,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 17),
                                  ),
                                ),
                                Visibility(
                                  visible: wordData.audio != "",
                                  child: GestureDetector(
                                    onTap: () => playSound(wordData.audio),
                                    child: Icon(
                                      Icons.volume_up,
                                      size: 30,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(
                                      right: 20, bottom: 20, top: 20),
                                  child: Text(
                                    "Part of Speech:",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Text(
                                  wordData.partOfSpeech,
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                            Row(
                              children: const [
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: 20, bottom: 20),
                                  child: Text("Meanings:",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 70),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  wordData.meanings.length,
                                  (index) => Meaning(
                                    definition:
                                        wordData.meanings[index].definition,
                                    example: wordData.meanings[index].example,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 60,
            margin: const EdgeInsets.only(right: 30, left: 30, bottom: 10),
            width: double.infinity,
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16))),
              child: const Text(
                "Add to Dictionary",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _saveData();
              },
            ),
          ),
        )
      ]),
    );
  }
}

class Meaning extends StatelessWidget {
  final String definition;
  final String example;

  const Meaning({Key? key, this.definition = "", this.example = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    definition,
                    style: const TextStyle(height: 1.5),
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible: example != "",
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  "Example:",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
                Flexible(
                  child: Text(
                    example,
                    style: const TextStyle(height: 1.5),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class WordData {
  String word;
  String phonetic;
  String audio;
  String partOfSpeech;
  List<MeaningText> meanings;

  WordData({
    this.word = "",
    this.phonetic = "",
    this.audio = "",
    this.partOfSpeech = "",
    this.meanings = const [],
  });

  factory WordData.fromJson(Map<String, dynamic> json) {
    List<dynamic> meaningList = json['meanings'];
    List<MeaningText> meanings =
        meaningList.map((meaning) => MeaningText.fromJson(meaning)).toList();
    return WordData(
      word: json['word'],
      phonetic: json['phonetic'],
      audio: json['audio'],
      partOfSpeech: json['partOfSpeech'],
      meanings: meanings,
    );
  }

  Map<String, dynamic> toJson() => {
        'word': word,
        'phonetic': phonetic,
        'audio': audio,
        'partOfSpeech': partOfSpeech,
        'meanings': meanings.map((meaning) => meaning.toJson()).toList(),
      };
}

class MeaningText {
  String definition = "";
  String example = "";

  MeaningText({
    this.definition = "",
    this.example = "",
  });

  factory MeaningText.fromJson(Map<String, dynamic> json) {
    return MeaningText(
      definition: json['definition'],
      example: json['example'],
    );
  }

  Map<String, dynamic> toJson() => {
        'definition': definition,
        'example': example,
      };
}

WordData getDataFromResponse(dynamic jsonData) {
  String word = jsonData[0]["word"] ?? "";
  String phonetic = jsonData[0]['phonetics'][0]['text'] ?? "";
  String audio = jsonData[0]['phonetics'][0]['audio'] ?? "";
  String partOfSpeech = jsonData[0]["meanings"][0]['partOfSpeech'] ?? "";
  List<MeaningText> meanings = [];

  for (var dif in jsonData[0]["meanings"][0]['definitions']) {
    String definition = dif["definition"] ?? "";
    String example = dif["example"] ?? "";
    meanings.add(MeaningText(definition: definition, example: example));
  }
  return WordData(
      word: word[0].toUpperCase() + word.substring(1),
      phonetic: phonetic,
      audio: audio,
      partOfSpeech: partOfSpeech,
      meanings: meanings);
}

// condition ? Text("True") : null,