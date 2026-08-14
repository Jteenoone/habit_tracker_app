import 'dart:math';

import 'package:habbit_tracker_app/model/habit.dart';

class StatisticsService {
  final List<Habit> habits;
  const StatisticsService(this.habits);

  double successRate(DateTime from, DateTime to) {
    int completed = 0;
    int total = 0;
    for(final habit in habits) {
      DateTime start = habit.startDay.isAfter(from)  ? habit.startDay : from; 
      for(DateTime y = start; y.isBefore(to) || y.isAtSameMomentAs(to); y = y.add(Duration(days: 1))) {
        if(habit.isDoneDay(y)) {
          completed++;
        }
        total++;
      }
    }
    if(total == 0) return 0;
    return completed / total;
  }

  int longestStreak(DateTime from, DateTime to) {
    int streak = 0;
    for(final habit in habits) {
      if(habit.startDay.isAfter(from) || habit.startDay.isAtSameMomentAs(from) && habit.startDay.isBefore(to)) {
        streak = max(streak, habit.streakCount);
      }
    }
    return streak;
  }

  int totalCompletions(DateTime from, DateTime to) {
    int completed = 0;
    for(final habit in habits) {
      DateTime start = habit.startDay.isAfter(from)  ? habit.startDay : from; 
      for(DateTime y = start; y.isBefore(to) || y.isAtSameMomentAs(to); y = y.add(Duration(days: 1))) {
        if(habit.isDoneDay(y)) {
          completed++;
        }
      }
    }
    return completed;
  }


  int activeHabits(DateTime from, DateTime to) {
    final List<Habit> listHabits = habits.where((h) => h.startDay.isAfter(from)).toList();
    return listHabits.length;
  }
}