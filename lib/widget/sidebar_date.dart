import 'package:flutter/material.dart';
import 'package:habbit_tracker_app/formatters/date_formatter.dart';

class SidebarDate extends StatefulWidget {
  final ValueChanged<DateTime> onSelect;
  const SidebarDate({super.key, required this.onSelect});

  @override
  State<SidebarDate> createState() => _SidebarDateState();
}

class _SidebarDateState extends State<SidebarDate> {
  late DateTime now = DateTime.now();
  late int weekday = now.weekday;
  late int day = now.day;
  int _indexOnTap = 6;
  List<String> weekName = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];

  late List<DateTime> dayof7 = List.generate(7, (index) => now.subtract(Duration(days: 6 - index)));

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (index) {
        bool isTap = _indexOnTap == index;
        return  GestureDetector(
          onTap: () {
            setState(() {
              _indexOnTap = index;
            });
            widget.onSelect(DateFormatter.dateTime(dayof7[index]));
          },
          child: _buildCardDay(weekName[dayof7[index].weekday - 1], dayof7[index].day, isTap)
        );
      })
    );
  }

  Widget _buildCardDay(String weekday, int day, bool isTap) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: isTap ? Color(0xFF5980A6) : Colors.white
      ),
      child: Column(
        children: [
          Text(weekday, style: !isTap ? TextStyle(color: Colors.grey, fontSize: 15) : TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
          SizedBox(height: 10,),
          Text('$day', style: TextStyle(
              color: isTap ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            fontSize: 15
          ),)
        ],
      ),
    );
  }
}