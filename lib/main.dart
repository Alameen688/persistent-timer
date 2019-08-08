import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/pomo.dart';
import 'pomo_history.dart';
import 'pomo_screen.dart';

void main() => runApp(ChangeNotifierProvider(
      builder: (context) => PomoModel(),
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tabbed Timer',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Iceberg'),
      home: Pomo(),
    );
  }
}

class Pomo extends StatefulWidget {
  @override
  _PomoState createState() => _PomoState();
}

class _PomoState extends State<Pomo> {
  List<Widget> _pages = <Widget>[PomoScreen(), PomoHistory()];
  int _currentIndex = 0;
  Widget _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = _pages[_currentIndex];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentPage,
      bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
              _currentPage = _pages[_currentIndex];
            });
          },
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.access_alarms), title: Text('Timer')),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), title: Text('Profile'))
          ]),
    );
  }
}
