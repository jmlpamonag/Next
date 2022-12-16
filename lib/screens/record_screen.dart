import 'package:flutter/material.dart';
import 'package:next/model/record.dart';
import 'package:intl/intl.dart';
import 'package:next/util/record_service.dart';


class RecordScreen extends StatefulWidget {
  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  var _recordTaskController = TextEditingController();
  var _recordTagController = TextEditingController();
  var _recordDateController = TextEditingController();
  var _recordFromController = TextEditingController();
  var _recordToController = TextEditingController();

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }
  DateTime _dateTime = DateTime.now();

  _selectedRecordDate(BuildContext context) async {
    var _pickedDate = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );

    if (_pickedDate != null) {
      setState(() {
        _dateTime = _pickedDate;
        _recordDateController.text = DateFormat('yyyy-MM-dd').format(_pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text('Add a Record'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _recordTaskController,
                decoration: InputDecoration(
                  labelText: 'Task',
                  hintText: 'Write your task here',
                ),
              ),
              TextField(
                controller: _recordTagController,
                decoration: InputDecoration(
                  labelText: 'Tag',
                  hintText: 'Write your tag here',
                ),
              ),
              TextFormField(
                controller: _recordDateController,
                decoration: InputDecoration(
                  labelText: 'Date',
                  hintText: 'Select Date',
                  prefixIcon: InkWell(
                    onTap: () {
                      _selectedRecordDate(context);
                    },
                    child: Icon(Icons.calendar_today),
                  ),
                ),
              ),
              TextField(
                controller: _recordFromController,
                decoration: InputDecoration(
                  labelText: 'From',
                  hintText: 'Start time',
                ),
              ),
              TextField(
                controller: _recordToController,
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
                  var recordObject = Record();

                  recordObject.task = _recordTaskController.text;
                  recordObject.tag = _recordTagController.text;
                  recordObject.date = _recordDateController.text;
                  recordObject.fromDate = _recordFromController.text;
                  recordObject.toDate = _recordToController.text;

                  var _recordService = RecordService();
                  var result = await _recordService.saveRecord(recordObject);
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
