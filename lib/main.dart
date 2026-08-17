import 'package:flutter/material.dart';
import 'package:habbit_tracker_app/provider/habit_provider.dart';
import 'package:habbit_tracker_app/screen/home_screen.dart';
import 'package:provider/provider.dart';

import 'model/habit.dart';
import 'screen/calendar_screen.dart';
import 'screen/setting_screen.dart';
import 'screen/statistics_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => HabitProvider(), 
      child: const MyApp()
    )
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> get listWidgets => <Widget>[
    HomeScreen(),
    CalendarScreen(),
    StatisticsScreen(),
    SettingScreen(),
  ];
  int _currentIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items:[
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month_outlined), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined), label: 'Statistics'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: 'Setting'),
        ],
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
      body: listWidgets[_currentIndex],
    );
  }
}


