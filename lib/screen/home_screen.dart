
import 'package:flutter/material.dart';
import 'package:habbit_tracker_app/formatters/date_formatter.dart';
import 'package:habbit_tracker_app/model/habit.dart';
import 'package:habbit_tracker_app/widget/list_habit.dart';
import 'package:habbit_tracker_app/widget/sidebar_date.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DateTime now = DateFormatter.dateTime(DateTime.now());
  DateTime selectedDate = DateFormatter.dateTime(DateTime.now());
  late List<Habit> habits = [
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
  @override
  Widget build(BuildContext context) {
    print(selectedDate.weekday);
   return Scaffold(
     body: Padding(padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
        child: Column(
         children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text('Hôm nay', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),),
                   Text(DateFormatter.dateFormat(now), style: TextStyle(color: Colors.grey),),
                 ],
               ),
               Container(
                 padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                 decoration: BoxDecoration(
                   border: Border.all(color: Colors.grey[400]!, width: 1),
                 ),
                 child: Row(
                   children: [
                     Icon(Icons.local_fire_department, color: Colors.blueGrey,),
                     SizedBox(width: 10,),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text('12', style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold,)),
                         Text('NGÀY LIỀN', style: TextStyle(color: Colors.grey),)
                       ],
                     )
                   ],
                 ),
               )
             ],
           ),
           SizedBox(height: 20,),
           SizedBox(
             height: 80,
            width: double.infinity,
            child: SidebarDate(onSelect: (d) => setState(() {selectedDate = d;}),),
           ),
           SizedBox(height: 10,),
           Expanded(
               child: ListHabit(day: selectedDate, habits: habits)
           ),
         ],
       ),
     )
   );
  }
}