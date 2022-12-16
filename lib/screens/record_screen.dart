import 'package:flutter/material.dart';
import 'package:next/model/record.dart';
import 'package:intl/intl.dart';
import 'package:next/util/record_service.dart';


class RecordScreen extends StatefulWidget {
  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  var _todoTaskController = TextEditingController();
  var _todoTagController = TextEditingController();
  var _todoDateController = TextEditingController();
  var _todoFromController = TextEditingController();
  var _todoToController = TextEditingController();

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }
  DateTime _dateTime = DateTime.now();

  _selectedTodoDate(BuildContext context) async {
    var _pickedDate = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );

    if (_pickedDate != null) {
      setState(() {
        _dateTime = _pickedDate;
        _todoDateController.text = DateFormat('yyyy-MM-dd').format(_pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text('Todo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _todoTaskController,
                decoration: InputDecoration(
                  labelText: 'Task',
                  hintText: 'Write your task here',
                ),
              ),
              TextField(
                controller: _todoTagController,
                decoration: InputDecoration(
                  labelText: 'Tag',
                  hintText: 'Write your tag here',
                ),
              ),
              TextFormField(
                controller: _todoDateController,
                decoration: InputDecoration(
                  labelText: 'Date',
                  hintText: 'Select Date',
                  prefixIcon: InkWell(
                    onTap: () {
                      _selectedTodoDate(context);
                    },
                    child: Icon(Icons.calendar_today),
                  ),
                ),
              ),
              TextField(
                controller: _todoFromController,
                decoration: InputDecoration(
                  labelText: 'From',
                  hintText: 'Start time',
                ),
              ),
              TextField(
                controller: _todoToController,
                decoration: InputDecoration(
                  labelText: 'To',
                  hintText: 'End time',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  var todoObject = Record();

                  todoObject.task = _todoTaskController.text;
                  todoObject.tag = _todoTagController.text;
                  todoObject.date = _todoDateController.text;
                  todoObject.fromDate = _todoFromController.text;
                  todoObject.toDate = _todoToController.text;

                  var _recordService = RecordService();
                  var result = await _recordService.saveRecord(todoObject);
                  if (result > 0) {
                    Navigator.pop(context);
                  }
           
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF151026)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
