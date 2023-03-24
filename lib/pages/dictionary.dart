import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Dictionary extends StatefulWidget {
  const Dictionary(BuildContext context, {super.key});

  @override
  State<Dictionary> createState() => _DictionaryState();
}

class _DictionaryState extends State<Dictionary> {
  final TextEditingController _controller = TextEditingController();
  String _textFieldValue = '';

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
              onSubmitted: (_) {
                setState(() {
                  _textFieldValue = _controller.text;
                });
                fetchData(_textFieldValue);
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 90),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Cooking",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "[ˈkʊkɪŋ]",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 17),
                            ),
                          ),
                          Icon(
                            Icons.volume_up,
                            size: 30,
                            color: Theme.of(context).primaryColor,
                          )
                        ],
                      ),
                      Row(
                        children: const [
                          Padding(
                            padding:
                                EdgeInsets.only(right: 20, bottom: 20, top: 20),
                            child: Text(
                              "Part of Speech:",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text(
                            "Noun",
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                      Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(right: 20, bottom: 20),
                            child: Text("Meanings:",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                      const Meaning(),
                      const Meaning(),
                      const Meaning(),
                      const Meaning(),
                      const Meaning(),
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
              onPressed: () {},
            ),
          ),
        )
      ]),
    );
  }

  Future<void> fetchData(String urlEndpoint) async {
    final apiUrl = Uri.parse(
        'https://api.dictionaryapi.dev/api/v2/entries/en/$urlEndpoint');
    final response = await http.get(apiUrl);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      print(jsonData[0]['phonetics'][0]['text']);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}

class Meaning extends StatelessWidget {
  const Meaning({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(
            Radius.circular(16.0) //                 <--- border radius here
            ),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Text(
              "The practice or skill of preparing food by combining, mixing, and heating ingredients.",
              style: TextStyle(height: 1.5),
            ),
          ),
          Row(
            children: [
              Text(
                "Example:",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
              const Text(" he developed an interest in cooking."),
            ],
          )
        ],
      ),
    );
  }
}

// class WordData {
//   String word = "";
//   String phonetic = "";

//   Person({required this.name, required this.age});

//   factory Person.fromJson(Map<String, dynamic> json) {
//     return Person(
//       name: json['name'],
//       age: json['age'],
//     );
//   }
// }
