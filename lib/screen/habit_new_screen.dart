import 'package:flutter/material.dart';

class HabitNewScreen extends StatefulWidget {
  const HabitNewScreen({super.key});

  @override
  State<HabitNewScreen> createState() => _HabitNewScreenState();
}

class _HabitNewScreenState extends State<HabitNewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thói quen mới'),
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close, size: 30,)),
      ),
      body: Center(
        child: Text('NEW HABIT'),
      ),
    );
  }
}