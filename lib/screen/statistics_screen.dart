import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:habbit_tracker_app/formatters/date_formatter.dart';
import 'package:habbit_tracker_app/model/habit.dart';
import 'package:habbit_tracker_app/provider/habit_provider.dart';
import 'package:habbit_tracker_app/service/statistics_service.dart';
import 'package:provider/provider.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  late  StatisticsService _statisticsService;

    @override
     void didChangeDependencies()  {
      super.didChangeDependencies();
      final habits = context.watch<HabitProvider>().habits;
      _statisticsService = StatisticsService(habits);

    }

  BarChartGroupData makeBar(int x, double value) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          width: 35,
          borderRadius: BorderRadius.zero
          )
      ]
      );
  }
  @override
  Widget build(BuildContext context) {
    final DateTime now = DateFormatter.dateTime(DateTime.now());
    final DateTime start = DateFormatter.dateTime(now.subtract(Duration(days: 29)));
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
      child: SingleChildScrollView(child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Thống kê', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),),
          Text('30 ngày qua', style: TextStyle(color: Colors.grey, fontSize: 15),),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _buildCardInfo('Tỉ lệ hoàn thành','${_statisticsService.successRate(start, now).toStringAsFixed(2)}' )),
              SizedBox(width: 10,),
              Expanded(child: _buildCardInfo('Chuỗi dài nhất', '${_statisticsService.longestStreak(start, now)}')),
            ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: 
              _buildCardInfo('Lần đánh dấu', '${_statisticsService.totalCompletions(start, now)}')
              ),
              SizedBox(width: 10,),
              Expanded(child: 
              _buildCardInfo('Thói quen đang theo', '${_statisticsService.activeHabits(start, now)}')
              ),
            ],
            ),
            SizedBox(height: 10,),
            Text('Theo thứ trong tuần', style: TextStyle(color: Colors.grey),),
            SizedBox(
              height: 200, 
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 100,
                  barGroups: [
                    makeBar(0, 80),
                    makeBar(1, 70),
                    makeBar(2, 85),
                    makeBar(3, 60),
                    makeBar(4, 40),
                    makeBar(5, 50),
                    makeBar(6, 70),
                  ],
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    show: true,
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const days = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
                          if (value.toInt() < 0 || value.toInt() >= days.length) return const Text('');
                          return Text(days[value.toInt()]);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            )        ],
      ),
    ));
  }

  Widget _buildCardInfo(String title, String num) {
    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(num, style: TextStyle(color: Colors.black, fontSize: 25),),
          SizedBox(height: 5,),
          Text(title, style: TextStyle(color: Colors.grey, fontSize: 15),),
        ],
      ),
    );
  }
}
