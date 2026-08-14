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
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
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
  final List<Habit> habits = [
    Habit(
      id: '01',
      name: 'Uống đủ nước',
      icon: Icons.water_drop_outlined,
      type: HabitType.count,
      weekDays: [1, 2, 3, 4],
      startDay: DateTime(2026, 8, 3),
      createAt: DateTime(2026, 8, 3),
      dailyProgress: { DateTime(2026, 8, 3): 0},
      maxCount: 8,
    ),
    Habit(
      id: '02',
      name: 'Chạy bộ 3km',
      icon: Icons.run_circle_outlined,
      type: HabitType.checkbox,
      weekDays: [1, 2, 3, 4],
      startDay: DateTime(2026, 8, 3),
      createAt: DateTime(2026, 8, 3),
      dailyProgress: { DateTime(2026, 8, 3): 0},
    ),
    Habit(
        id: '03',
        name: 'Học tiếng anh',
        icon: Icons.book_rounded,
        type: HabitType.duration,
        weekDays: [1, 2, 3, 4, 5],
        startDay: DateTime(2026, 8, 3),
        createAt: DateTime(2026, 8, 3),
        dailyProgress: { DateTime(2026, 8, 3): 0},
        targetMinutes: 1
    ),
    Habit(
      id: '04',
      name: 'Học thuốc lá',
      icon: Icons.not_interested_outlined,
      type: HabitType.avoidance,
      weekDays: [1, 2, 3, 4, 5, 6, 7],
      startDay: DateTime(2026, 8, 3),
      createAt: DateTime(2026, 8, 3),
      dailyProgress: { DateTime(2026, 8, 3): 0},
    )
  ];
  List<Widget> get listWidgets => <Widget>[
    HomeScreen(habits: habits,),
    CalendarScreen(habits: habits),
    StatisticsScreen(habits: habits,),
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


