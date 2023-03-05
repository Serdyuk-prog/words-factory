import 'package:flutter/material.dart';
import 'package:words_factory/content_modal.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                itemCount: contents.length,
                itemBuilder: (_, i) {
                  return Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Image.asset(
                          contents[i].image,
                          height: 300,
                        ),
                        Text(contents[i].title,
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                height: 1.33),
                            textAlign: TextAlign.center),
                        Text(
                          contents[i].description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 1.5),
                        )
                      ],
                    ),
                  );
                }),
          ),
          Container(
            height: 55,
            width: double.infinity,
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
