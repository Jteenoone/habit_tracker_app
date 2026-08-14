import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habbit_tracker_app/formatters/date_formatter.dart';
import 'package:habbit_tracker_app/model/habit.dart';

class CalendarWidget extends StatefulWidget {
  final List<Habit> habits;
  final ValueChanged<DateTime> onSelected;
  
  const CalendarWidget({super.key, required this.habits, required this.onSelected});
  
  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final List<String> days = [
    'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'
  ];
  late DateTime currentMonth = DateFormatter.dateTime(DateTime.now());
  int get daysInMonth => DateTime(
      currentMonth.year,
    currentMonth.month + 1,
    0
  ).day;
  final List<Color> colors= [
    Color(0xFF2C455D),
    Color(0xFF749DC4),
    Color(0xFFB5D9FD),
    Color(0xFFD6EBFF),
    Colors.white
  ];
  late DateTime currentDay = currentMonth;
  int get firstDay => DateTime(
    currentMonth.year,
    currentMonth.month,
    1
  ).weekday;
  late int totalItem = (firstDay - 1) + daysInMonth;
  void previousMonth() {
    setState(() {
      if(currentMonth.month > 1) {
        currentMonth = DateTime(
            currentMonth.year,
            currentMonth.month - 1,
            1
        );
      } else {
        currentMonth = DateTime(
          currentMonth.year - 1,
          12,
          1
        );
      }
      widget.onSelected(currentMonth);
      currentDay = currentMonth;
    });
  }

  void nextMonth() {
    setState(() {
      if(currentMonth.month < 12) {
        currentMonth = DateTime(
          currentMonth.year,
          currentMonth.month + 1,
          1
        );
      } else {
        currentMonth = DateTime(
          currentMonth.year + 1,
          currentMonth.month,
          1
        );
      }
      widget.onSelected(currentMonth);
      currentDay = currentMonth;
    });
  }
  
  void onTap(int day) {
    setState(() {
      currentDay = DateTime(currentMonth.year, currentMonth.month, day);
      widget.onSelected(currentDay);
    });
  }

  String get dateTime {
    int m = currentMonth.month;
    int y = currentMonth.year;
    return 'Tháng $m, $y';
  }
  @override
  Widget build(BuildContext context) {
    return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: previousMonth, icon: Icon(Icons.arrow_back)),
          Text(dateTime, style: TextStyle(color: Colors.black, fontSize: 20),),
          IconButton(onPressed: nextMonth, icon: Icon(Icons.arrow_forward))
        ],
      ),
    GridView.builder(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
        ),
        itemCount: 7,
        itemBuilder: (context, index) {
          return Center(child: Text(days[index], style: TextStyle(color: Colors.grey),),);
        }
    ),
    SizedBox(height: 4,),
    GridView.builder(
      padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              childAspectRatio: 1
            ),
            itemCount: totalItem,
            itemBuilder: (context, index) {
              bool isDayInMonth = index >= firstDay - 1;
              if(!isDayInMonth) {
                return Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!, width: 1)
                    )
                );
              }
              int day = index - (firstDay - 1) + 1;
              bool isSelected = day == currentDay.day;
              
              DateTime dateTime = DateFormatter.dateTime(DateTime(currentMonth.year, currentMonth.month, day));
              final habitOfDay = widget.habits.where((h) => h.isActiveOne(dateTime)).toList();
              final progress = habitOfDay.fold(
                0,
                (sum, h) => sum + (h.isDoneDay(dateTime) ? 1 : 0),
              ) / habitOfDay.length;
              final today = DateTime.now();
              final isPastOrToday =
                  dateTime.year < today.year ||
                  (dateTime.year == today.year && dateTime.month < today.month) ||
                  (dateTime.year == today.year &&
                      dateTime.month == today.month &&
                      dateTime.day <= today.day);

              Color color = Colors.white;
              if (isPastOrToday) {
                if(progress  > 0.9) {
                  color = colors[0];
                } else if(progress > 0.7) {
                  color = colors[1];
                } else if(progress > 0.5) {
                  color = colors[2];
                } else if(progress > 0.3) {
                  color = colors[3];
                }
              }
              bool isColorWhite = color == Colors.white;
              return GestureDetector(
                onTap: () => onTap(day),
                child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color,
                  border: Border.all(color: isSelected ? Colors.black : Colors.grey, width: isSelected ? 2 : isColorWhite ? 1 : 0)
                ),
                child:Text('$day')
                
              )
              );
            }
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            Text('ít'),
            SizedBox(width: 10,),
            Row(
              spacing: 10,
              children: List.generate(colors.length, (index) {
                return Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: colors[colors.length - index - 1],
                    border: Border.all(color: Colors.grey, width: index == 0 ? 1 : 0)
                  ),
                );
              })
              ,),
              SizedBox(width: 10),
              Text('đủ')
          ],
          )
    ]
    );
  }
}