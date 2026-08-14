import 'dart:async';

import 'package:flutter/material.dart';

class CircularCountdown extends StatefulWidget {
  final Duration duration;
  final VoidCallback? onFinish;

  const CircularCountdown({super.key, required this.duration, this.onFinish});

  @override
  State<CircularCountdown> createState() => _CircularCountdownState();
}

class _CircularCountdownState extends State<CircularCountdown> {
  late Duration remaining = widget.duration;
  late Timer _timer;

  void _start() {
      _timer = Timer.periodic(Duration(seconds: 1), (t) {
        if(remaining.inSeconds <= 1) {
          _timer.cancel();
          setState(() {
            remaining = Duration.zero;
          });
          widget.onFinish!();
        } else {
          setState(() {
            remaining -= const Duration(seconds: 1);
          });
        }
      });
  }

  double get _progress {
    final total = widget.duration.inMilliseconds;
    if(total == 0) return 0;
    return remaining.inMilliseconds / total;
  }

  String get _label {
    final s = (remaining.inSeconds % 60).toString().padLeft(2, '0');
    final m = remaining.inMinutes.toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 200,
          height: 200,
          child:Stack(
            alignment: Alignment.center,
            children: [
              SizedBox.expand(
                child: CircularProgressIndicator(
                  value: _progress,
                  strokeWidth: 12,
                  strokeCap: StrokeCap.round,
                  backgroundColor: Colors.green.withOpacity(0.15),
                  valueColor: AlwaysStoppedAnimation(Colors.green),
                ),
              ),
              Text(_label, style: TextStyle(color: Colors.black),),
            ],
          ),
        ),
        IconButton(onPressed: _start, icon: Icon(Icons.play_arrow))
      ],
    );
  }
}