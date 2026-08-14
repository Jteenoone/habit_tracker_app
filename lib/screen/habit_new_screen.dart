import 'package:flutter/material.dart';
import 'package:habbit_tracker_app/formatters/date_formatter.dart';
import 'package:habbit_tracker_app/model/habit.dart';
import 'package:habbit_tracker_app/provider/habit_provider.dart';
import 'package:provider/provider.dart';

class HabitNewScreen extends StatefulWidget {
  const HabitNewScreen({super.key});

  @override
  State<HabitNewScreen> createState() => _HabitNewScreenState();
}

class _HabitNewScreenState extends State<HabitNewScreen> {
  final TextEditingController _habitNameInputController = TextEditingController();
  late IconData icon;
  late HabitType habitType;
  late int target; 
  List<int> selectedDay = [];
  List<HabitType> listHabitType =[
    HabitType.checkbox,
    HabitType.count,
    HabitType.duration,
    HabitType.avoidance
  ];

  List<IconData> listIcons = [
    Icons.water_drop_outlined,
    Icons.timer_outlined,
    Icons.check_box_outline_blank,
    Icons.not_interested_outlined,
    Icons.add,
  ];

  final List<String> listDays = [
    'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'
  ];
  int _indexSelected = 0;
  int selectedValue = 1;
  int indexIconSelected = 0;
  @override
  void dispose() {
    _habitNameInputController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thói quen mới'),
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close, size: 30,)),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('TÊN THÓI QUEN', style: TextStyle(color: Colors.grey),),
            SizedBox(height: 5,),
            TextField(
              controller: _habitNameInputController,
              decoration: InputDecoration(
                hintText: 'Nhập tên thói quen',
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey
                  )
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2
                  )
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18)
              ),
            ),
            SizedBox(height: 10,),
            Text('KIỂU THOI DÕI', style: TextStyle(color: Colors.grey),),
            SizedBox(height: 5,),
            SizedBox(
              width: double.infinity,
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: listHabitType.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3
                  ),
                  itemBuilder: (context, index) {
                    bool isSelected = _indexSelected == index;
                    return _buildCardTypeHabit(listHabitType[index].label, () {
                      setState(() {
                        _indexSelected = index;
                      });
                    }, isSelected);
                  }
              )
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mục tiêu trong ngày', style: TextStyle(color: Colors.grey),),
                      Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                       decoration: BoxDecoration(
                         border: Border.all(color: Colors.grey, width: 1),

                       ),
                       child: DropdownButton<int>(
                        value: selectedValue,
                          isExpanded: true,
                          underline: const SizedBox(),
                          items: List.generate(10,
                              (index) => DropdownMenuItem(
                                value: index + 1,
                                  child: Text('${index + 1}'))
                          ), onChanged: (value) {
                            setState(() {
                              selectedValue = value!;
                            });
                      }),
                      )
                  ],
                )
                ),
                SizedBox(width: 10,),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nhắc lúc', style: TextStyle(color: Colors.grey),),
                    Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('07:00', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
                          Icon(Icons.timer_outlined),
                        ],
                      ),
                    )
                  ],
                )
                )
              ],
            ),
            SizedBox(height: 10,),
            Text('Lặp lại', style: TextStyle(color: Colors.grey),),
            SizedBox(height: 5,),
            Row(
              spacing: 5,
              children: List.generate(7, (index) {
                bool isSelected = selectedDay.contains(index + 1);
                return Expanded(child: _buildCardDay(listDays[index],() {
                  setState(() {
                    if(isSelected) {
                      selectedDay.remove(index + 1);
                    } else {
                      selectedDay.add(index + 1);
                    }
                  });
                } , isSelected
                ));
              }),
            ),
            SizedBox(height: 10,),
            Text('Biểu tượng', style: TextStyle(color: Colors.grey),),
            SizedBox(height: 5,),
            Row(
              spacing: 5,
              children: List.generate(
                  listIcons.length
                  , (index) {
                bool isSelected = index == indexIconSelected;
               return Expanded(
                   child: _buildCardIcon(listIcons[index], isSelected, () {
                     setState(() {
                       indexIconSelected = index;
                 });
               })
               );
              }),
            ),
            Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: GestureDetector(
                onTap: () {
                  context.read<HabitProvider>().addHabit(
                  Habit(id: '03',
                   name: _habitNameInputController.text,
                    icon: icon, type: habitType,
                     weekDays: selectedDay,
                      startDay: DateFormatter.dateTime(DateTime.now()),
                       createAt:  DateFormatter.dateTime(DateTime.now())
                       )
                  );
                }, 
              child: Center(
                child: Text(
                  'Lưu thói quen',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            )
            )
          ],
        )
      )
    );
  }

  Widget _buildCardIcon(IconData icon, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[200] : Colors.white,
          border: Border.all(color: isSelected ? Colors.blue : Colors.grey, width: 0.5),
        ),
        child: Center(
          child: Icon(icon, color: isSelected ? Colors.blue : Colors.grey,),
        ),
      ),
    );
  }

  Widget _buildCardDay(String name, VoidCallback onTap, bool isSelected) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: isSelected ? 0 : 1
          ),
        ),
        child: Center(
          child: Text(name, style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
  Widget _buildCardTypeHabit(String name, VoidCallback onTap, bool isSelected) {
    return GestureDetector(
      onTap: onTap,
      child: Container(

        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueAccent : Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 1
          )
        ),
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 12),
        child: Text(name, style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 15
        ),),
      ),
    );
  }
}