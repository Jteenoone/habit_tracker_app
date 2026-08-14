import 'dart:async';

import 'package:flutter/material.dart';
import 'package:habbit_tracker_app/widget/circular_countdown.dart';

class TimerScreen extends StatelessWidget {
  final Duration duration;
  final VoidCallback onFinish;

  const TimerScreen({super.key, required this.duration, required this.onFinish});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(),
      body:Center(child:  CircularCountdown(duration: duration, onFinish: onFinish,)),
    backgroundColor: Colors.white,
    );
  }
}

class CountdownTimer extends StatefulWidget {
  final Duration duration;
  const CountdownTimer({super.key, required this.duration});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();


}

class _CountdownTimerState extends State<CountdownTimer> {
  late Duration remaining = widget.duration;
  Timer? _timer;

  void _start() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if(remaining.inSeconds <= 1) {
        t.cancel();
        setState(() {
          remaining = Duration.zero;
        });

      } else {
       setState(() {
         remaining -= const Duration(seconds: 1);
       });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get text{
    final m = remaining.inMinutes.toString().padLeft(2, '0');
    final s = (remaining.inSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text('$text', style: TextStyle(fontSize: 25),),
      IconButton(onPressed: _start, icon: const Icon(Icons.play_arrow))
    ],
  );
}