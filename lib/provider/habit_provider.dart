import 'package:flutter/material.dart';
import 'package:habbit_tracker_app/model/habit.dart';

class HabitProvider extends ChangeNotifier{
  final List<Habit> _habits = [
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