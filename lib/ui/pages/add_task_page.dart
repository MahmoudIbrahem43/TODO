import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_todo_app/controllers/task_controller.dart';
import 'package:my_todo_app/ui/theme.dart';
import 'package:my_todo_app/ui/widgets/button.dart';
import 'package:my_todo_app/ui/widgets/input_field.dart';

import '../../models/task.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 1)))
      .toString();
  String _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectRepeat = 'None';
  List<String> repeateList = ['None', 'Daily', 'Weekly', 'Monthly'];
  int selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? darkGreyClr : Colors.white,
      appBar: _appBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(children: [
            Text(
              'Add Task',
              style: headingStyle,
            ),
            InputField(
              title: 'Ttile',
              hint: 'enter a title here .. ',
              controller: _titleController,
            ),
            const SizedBox(
              height: 15,
            ),
            InputField(
              title: 'Note',
              hint: 'enter a note here .. ',
              controller: _noteController,
            ),
            const SizedBox(
              height: 15,
            ),
            InputField(
              title: 'Date',
              hint: DateFormat.yMd().format(_selectDate),
            
              icon: IconButton(
                  onPressed: () {
                    _getDateFromUser();
                  },
                  icon: Icon(Icons.calendar_today_outlined)),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: InputField(
                    title: 'Start Time',
                    hint: _startTime,
                  
                    icon: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: true);
                        },
                        icon: Icon(Icons.calendar_today_outlined)),
                  ),
                ),
                Expanded(
                  child: InputField(
                    title: 'End Time',
                    hint: _endTime,
                    
                    icon: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: true);
                        },
                        icon: const Icon(Icons.calendar_today_outlined)),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            InputField(
              title: 'Reminder',
              hint: '$_selectedRemind minutes early',
              icon: DropdownButton(
                  borderRadius: BorderRadius.circular(8),
                  dropdownColor: Colors.blueGrey,
                  items: remindList
                      .map(
                        (val) => DropdownMenuItem(
                          value: val,
                          child: Text(
                            '$val',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                      .toList(),
                  underline: Container(
                    height: 0,
                  ),
                  style: subTitleStyle,
                  elevation: 4,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    size: 32,
                    color: Colors.grey,
                  ),
                  onChanged: (int? val) {
                    setState(() {
                      _selectedRemind = val!;
                    });
                  }),
            ),
            const SizedBox(
              height: 15,
            ),
            InputField(
              title: 'Repeat',
              hint: '$_selectRepeat',
              icon: DropdownButton(
                  borderRadius: BorderRadius.circular(8),
                  dropdownColor: Colors.blueGrey,
                  items: repeateList
                      .map(
                        (val) => DropdownMenuItem(
                          value: val,
                          child: Text(
                            '$val',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                      .toList(),
                  underline: Container(
                    height: 0,
                  ),
                  style: subTitleStyle,
                  elevation: 4,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    size: 32,
                    color: Colors.grey,
                  ),
                  onChanged: (String? val) {
                    setState(() {
                      _selectRepeat = val!;
                    });
                  }),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPalet(),
                  MyButton(
                      lable: 'Create Task',
                      onTab: () {
                        _validateData();
                      })
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  _colorPalet() {
    return Column(
      children: [
        Text(
          'Color',
          style: titleStyle,
        ),
        const SizedBox(
          height: 2,
        ),
        Row(
          children: List.generate(
            3,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                child: CircleAvatar(
                  radius: 15,
                  child: selectedColor == index
                      ? const Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 16,
                        )
                      : Container(),
                  backgroundColor: index == 0
                      ? primaryClr
                      : index == 1
                          ? pinkClr
                          : orangeClr,
                ),
                onTap: () {
                  setState(() {
                    selectedColor = index;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: Get.isDarkMode ? darkGreyClr : Colors.white,
      elevation: 0,
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 24,
            color: Get.isDarkMode ? Colors.white : darkGreyClr,
          )),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 5),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/person.jpeg'),
            radius: 25,
          ),
        )
      ],
    );
  }

  _validateData() {
     
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDb();
      Get.back();
    } 
    else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar('required', 'All Fields Are Required',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: pinkClr,
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
          ));
    } else {
      print('something wrong');
    }
  }

  _addTaskToDb() async {
    int value = await _taskController.addTask(
        task: Task(
            title: _titleController.text,
            note: _noteController.text,
            isCompleted: 0,
            date: DateFormat.yMd().format(_selectDate),
            color: selectedColor,
            remind: _selectedRemind,
            repeat: _selectRepeat,
            startTime: _startTime,
            endTime: _endTime));
    print(value.toString());
  }

  void _getDateFromUser() async {
    DateTime? _pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2230));
    if (_pickedDate != null) {
      setState(() {
        _selectDate = _pickedDate;
      });
    } else {
      print('it\'s null or somthing wrong');
    }
  }

  void _getTimeFromUser({required bool isStartTime}) async {
    TimeOfDay? _pickedTime = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
              DateTime.now().add(const Duration(minutes: 15))),
    );

    String _formattedTime = _pickedTime!.format(context);
    if (isStartTime == true) {
      setState(() {
        _startTime = _formattedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formattedTime;
      });
    } else {
      print('it\'s null or somthing wrong');
    }
  }
}
