
import 'package:flutter/material.dart';
import 'package:habbit_tracker_app/formatters/date_formatter.dart';

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
    final d = _normalize(date);
    if(d.isBefore(DateTime(startDay.day, startDay.month, startDay.year))) {
      return false;
    } if(endDay != null && d.isAfter(endDay!)) {
      return false;
    }
    return weekDays.contains(date.weekday);
  }

  bool isDoneDay(DateTime date) {
    final d = _normalize(date);
    int dayProgress = dailyProgress[d] ?? 0;
    if(type == HabitType.avoidance) return true;
    return dayProgress >= target;
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

extension HabitTypeExtension on HabitType{
  String get label {
    switch(this) {
      case HabitType.checkbox:
        return 'Xong/ chưa';
      case HabitType.count:
        return 'Đếm số lần';
      case HabitType.duration:
        return 'Thời lượng';
      case HabitType.avoidance:
        return 'Thói quen khó bỏ';
    }
  }
}