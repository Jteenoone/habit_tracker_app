import 'package:flutter/material.dart';
import 'package:habbit_tracker_app/model/habit.dart';
import 'package:habbit_tracker_app/screen/timer_screen.dart';

class CardHabit extends StatefulWidget{
  final Habit habit;
  final DateTime day;
  const CardHabit({super.key, required this.habit, required this.day});

  @override
  State<CardHabit> createState() => _CardHabitState();
}

class _CardHabitState extends State<CardHabit> {
  @override

  void _onTapCount() {
    final current = widget.habit.dailyProgress[widget.day] ?? 0;
    if(current >= widget.habit.maxCount!) return;
    setState(() {
      widget.habit.dailyProgress[widget.day] = current + 1;
      if(widget.habit.isDoneToday) {
        widget.habit.streakCount += 1;
      }
    });
  }

  void onCheck(value) {
    final current = widget.habit.dailyProgress[widget.day] ?? 0;
    setState(() {
      widget.habit.dailyProgress[widget.day] = current >= 1 ? 0 : 1;
    });
    if(widget.habit.isDoneToday) {
      widget.habit.streakCount += 1;
    } else {
      widget.habit.streakCount -= 1;
    }
  }

  void _onFinish() {
    setState(() {
      widget.habit.dailyProgress[widget.day] = 1;
      widget.habit.streakCount += 1;
    });
  }

  void onContinue() {}
  Widget build(BuildContext context) {
    String title = 'Chuỗi ${widget.habit.streakCount} ngày';
    if(widget.habit.type == HabitType.duration) {
      title = '${widget.habit.dailyProgress[widget.day] ?? 0}/${widget.habit.targetMinutes} * $title';
    } else if(widget.habit.type == HabitType.checkbox && !widget.habit.isDoneToday) {
      title = 'Chưa xong * $title';
    }
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFD0D0D1), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFD0D0D1), width: 1)
            ),
            child: Icon(widget.habit.icon, color: Colors.blueAccent,),
          ),
          SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.habit.name, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),),
              widget.habit.type != HabitType.avoidance ? Text(title, style: TextStyle(color: Colors.grey),) : Text('Thói quen cần bỏ'),
            ],
          ),
          ]),
          _buildAction(),
        ],
      ),
    );
  }

  Widget _buildAction() {
    switch(widget.habit.type) {
      case HabitType.count:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${widget.habit.dailyProgress[widget.day] ?? 0}/${widget.habit.maxCount}'),
            SizedBox(width: 5,),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent, width: 0.5),
              ),
              child: GestureDetector(
                onTap: _onTapCount,
                  child: Icon(Icons.add, color: Colors.blueAccent,)
              ),
            )
          ],
        );
      case HabitType.checkbox:
        return Checkbox(value: widget.habit.isDoneDay(widget.day), onChanged: onCheck);
      case HabitType.duration:
        return
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent, width: 1)
          ),
          child: widget.habit.isDoneToday ?
              Text('Đã hoàn thành')
          : GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TimerScreen(duration: Duration(minutes: widget.habit.targetMinutes ?? 0), onFinish: () {
              Navigator.pop(context);
              _onFinish();
            }))),
            child: Text('Tiếp tục', style: TextStyle(color: Colors.blueAccent),),
          ),
        );
      case HabitType.avoidance:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('${widget.habit.streakCount}', style: TextStyle(color: Colors.blueAccent, fontSize: 18),),
            Text('Ngày sạch', style: TextStyle(color: Colors.grey, fontSize: 13),)
          ],
        );
    }
  }
}