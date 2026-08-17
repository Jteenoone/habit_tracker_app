import 'package:habbit_tracker_app/model/habit.dart';
import 'package:hive/hive.dart';

class HabitRepository {
  final Box<Habit> box;

  HabitRepository(this.box);

  List<Habit> getHabits() {
    return box.values.toList();
  }

  Future<void> saveHabit(Habit habit) async{
    await box.put(habit.id, habit);
  }

  Future<void> deleteHabit(String id) async {
    await box.delete(id);
  }

  Habit? getHabit(String id) {
    return box.get(id);
  }

  Future<void> deleteAll() async {
    await box.clear();
  }
}