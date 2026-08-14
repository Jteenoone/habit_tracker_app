import 'package:flutter/material.dart';
import 'package:habbit_tracker_app/formatters/date_formatter.dart';
import 'package:habbit_tracker_app/provider/habit_provider.dart';
import 'package:habbit_tracker_app/widget/calendar_widget.dart';
import 'package:provider/provider.dart';

import '../model/habit.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});
  
  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime currentDate = DateFormatter.dateTime(DateTime.now());

  String _label(Habit habit) {
    if(habit.type == HabitType.count || habit.type == HabitType.duration) {
      return '${habit.dailyProgress[currentDate] ?? 0}/${habit.target}';
    }
    return habit.isDoneDay(currentDate) ? 'Xong' : 'Chưa xong';
  }

  @override
  Widget build(BuildContext context) {
    final habits = context.watch<HabitProvider>().habits;
   final habitOfDay = habits.where((h) => h.isActiveOne(currentDate)).toList();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Lịch', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),),
          Text('Toàn bô thói quen', style: TextStyle(color: Colors.grey, fontSize: 15),),
          SizedBox(height: 10,),
          CalendarWidget(habits: habits, onSelected: (d) => setState(() {
            setState(() {
              currentDate = d;
            });
          })),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DateFormatter.dateFormat(currentDate), style: TextStyle(color: Colors.grey),),
            SizedBox(height: 5,),
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: habitOfDay.length,
                itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(habitOfDay[index].name),
                    Text('${_label(habitOfDay[index])}')
                  ]
                  );
                }
            ),
            ]),
          ),
        ],
      ),
    );
  }
}