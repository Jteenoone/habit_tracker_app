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
              return GestureDetector(
                onTap: () => onTap(day),
                child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: isSelected ? Colors.black : Colors.grey, width: isSelected ? 2 : 1)
                ),
                child: isDayInMonth ?
                Text('$day')
                    :null
              )
              );
            }
        )
    ]
    );
  }
}