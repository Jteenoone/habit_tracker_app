import 'package:flutter/material.dart';
import 'package:habbit_tracker_app/model/habit.dart';

class HabitProvider extends ChangeNotifier{
  final List<Habit> _habits = [
     Habit(
      id: '01',
      name: 'Uống đủ nước',
      iconName: 'water',
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
      iconName: 'run',
      type: HabitType.checkbox,
      weekDays: [1, 2, 3, 4],
      startDay: DateTime(2026, 8, 3),
      createAt: DateTime(2026, 8, 3),
      dailyProgress: { DateTime(2026, 8, 3): 0},
    ),
    Habit(
        id: '03',
        name: 'Học tiếng anh',
        iconName: 'book',
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
      iconName: 'not',
      type: HabitType.avoidance,
      weekDays: [1, 2, 3, 4, 5, 6, 7],
      startDay: DateTime(2026, 8, 3),
      createAt: DateTime(2026, 8, 3),
      dailyProgress: { DateTime(2026, 8, 3): 0},
    )
  ];
  List<Habit> get habits => _habits;

  void addHabit(Habit habit) {
    _habits.add(habit);
    notifyListeners();
  }

  void deleteHabit(Habit habit) {
    _habits.remove(habit);
    notifyListeners();
  }
}