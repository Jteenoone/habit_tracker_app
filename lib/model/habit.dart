
import 'package:flutter/material.dart';

enum HabitType {checkbox, count, duration, avoidance}

class Habit {
  final String id;
  final String name;
  final IconData icon;
  final HabitType type;
  final List<int> weekDays;
  final DateTime startDay;
  final DateTime? endDay;

  final int? targetMinutes;

  final int? maxCount;
  final String? unit;

  final DateTime? clearStartDate;

  final Map<DateTime, int> dailyProgress;

  final DateTime createAt;
  int streakCount;

  Habit({
    required this.id,
    required this.name,
    required this.icon,
    required this.type,
    required this.weekDays,
    required this.startDay,
    this.endDay,
    this.targetMinutes,
    this.maxCount,
    this.unit,
    this.clearStartDate,
    this.dailyProgress = const {},
    this.streakCount = 0,
    required this.createAt
  });

  static DateTime _normalize(DateTime date) => DateTime(date.year, date.month, date.day);

  bool isActiveOne(DateTime date) {
    final d = DateTime(date.day, date.month, date.year);
    if(d.isBefore(DateTime(startDay.day, startDay.month, startDay.year))) {
      return false;
    } if(endDay != null && d.isAfter(endDay!)) {
      return false;
    }
    return weekDays.contains(date.weekday);
  }

  int get todayProgress {
    final key = _normalize(DateTime.now());
    return dailyProgress[key] ?? 0;
  }
  int get target {
    switch(type) {
      case HabitType.checkbox:
        return 1;
      case HabitType.count:
        return maxCount ?? 0;
      case HabitType.duration:
        return targetMinutes ?? 0;
      case HabitType.avoidance:
        return 0;
    }
  }
  bool get isDoneToday {
    if(type == HabitType.avoidance) return true;
    return todayProgress >= target;
  }

  int get clearDays {
    if(clearStartDate == null) return 0;
    return DateTime.now().difference(clearStartDate!).inDays;
  }
}