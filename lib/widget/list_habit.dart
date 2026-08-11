
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:habbit_tracker_app/model/habit.dart';
import 'package:habbit_tracker_app/widget/card_habit.dart';

class ListHabit extends StatefulWidget {
  final DateTime day;
  final List<Habit> habits;

  const ListHabit({super.key, required this.day, required this.habits});

  @override
  State<ListHabit> createState() => _ListHabitState();
}

class _ListHabitState extends State<ListHabit> {
  @override
  Widget build(BuildContext context) {
    final habitsDay = widget.habits.where((habit) => habit.weekDays.contains(widget.day.weekday)).toList();
    return ListView.builder(
      itemCount: habitsDay.length,
        itemBuilder: (context, index) {
          return Slidable(
            startActionPane: ActionPane(
                motion: const ScrollMotion(),
                extentRatio: 0.45,
                children: [
                  SlidableAction(
                      onPressed: (context) {
                        //sua
                      },
                    backgroundColor: Colors.blue.shade100,
                    foregroundColor: Colors.black,
                    icon: Icons.edit_outlined,
                    label: 'Sửa',
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      // xoa
                    },
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    icon: Icons.delete_outline,
                    label: 'Xóa',
                  ),
                ]
            ),
              child: CardHabit(habit: habitsDay[index], day: widget.day)
          );
        }
    );
  }
  Widget _buildHabit(int? count, String title,Habit habit) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFD0D0D1), width: 1),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFD0D0D1), width: 1)
            ),
            child: Icon(habit.icon, color: Colors.blueAccent,),
          ),
          Column(
            children: [
              Text(habit.name, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text(title, style: TextStyle(color: Colors.grey),),
            ],
          ),
        ],
      ),
    );
  }
}