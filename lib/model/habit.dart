
import 'package:flutter/material.dart';
import 'package:habbit_tracker_app/formatters/date_formatter.dart';
import 'package:hive/hive.dart';
part 'habit.g.dart';

@HiveType(typeId: 1)
enum HabitType {
  @HiveField(0)
  checkbox,

  @HiveField(1)
  count,

  @HiveField(2)
  duration,

  @HiveField(3)
  avoidance
  }

@HiveType(typeId: 0)
class Habit {
  @HiveField(0)
  final String id;

   @HiveField(1)
  final String name;

   @HiveField(2)
  final String iconName;

   @HiveField(3)
  final HabitType type;

   @HiveField(4)
  final List<int> weekDays;

   @HiveField(5)
  final DateTime startDay;

   @HiveField(6)
  final DateTime? endDay;

  @HiveField(7)
  final int? targetMinutes;

  @HiveField(8)
  final int? maxCount;

   @HiveField(9)
  final String? unit;

   @HiveField(10)
  final DateTime? clearStartDate;

   @HiveField(11)
  final Map<DateTime, int> dailyProgress;
  
   @HiveField(12)
  final DateTime createAt;
  
  @HiveField(13)
  int streakCount;

  Habit({
    required this.id,
    required this.name,
    required this.iconName,
    required this.type,
    required this.weekDays,
    required this.startDay,
    this.endDay,
    this.targetMinutes,
    this.maxCount,
    this.unit,
    this.clearStartDate,
    Map<DateTime, int>? dailyProgress, 
    this.streakCount = 0,
    required this.createAt
  }) : dailyProgress = dailyProgress != null ? Map.from(dailyProgress) :  {};

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