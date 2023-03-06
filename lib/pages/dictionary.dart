import 'package:flutter/material.dart';

class Dictionary extends StatelessWidget {
  const Dictionary(BuildContext context, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 30),
            child: TextField(
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w400, height: 1),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16.0),
                    ),
                  ),
                  hintText: 'Cooking',
                  suffixIcon: IconButton(
                      color: Colors.black,
                      onPressed: null,
                      icon: Icon(Icons.search))),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
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
                            fontSize: 17
                          ),
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
                        padding: EdgeInsets.only(right: 20, bottom: 20, top: 20),
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
                ],
              ),
            ),
          ),

        Container(
            height: 60,
            margin: const EdgeInsets.only(right: 30, left: 30, bottom: 20),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16))),
              child: const Text(
                "Add to Dictionary",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {},
            ),
          )

        ],
      ),
    );
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
