import 'package:flutter/material.dart';
import 'package:words_factory/pages/dictionary.dart';
import 'package:words_factory/pages/training.dart';
import 'package:words_factory/pages/video.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = <Widget>[
      Dictionary(context),
      Training(context),
      Video(context),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: pages.elementAt(_selectedIndex), //New
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            border: Border.all(color: Colors.grey)),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey[400],
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                label: 'Dictionary',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.web_stories),
                label: 'Training',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.play_circle),
                label: 'Video',
              ),
            ],
            currentIndex: _selectedIndex, //New
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
