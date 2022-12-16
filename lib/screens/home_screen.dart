import 'package:flutter/material.dart';
import 'package:next/model/record.dart';
import 'package:next/screens/record_screen.dart';
import 'package:next/util/record_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RecordService _recordService;

  List<Record> _recordList = <Record>[];


  @override
  initState() {
    super.initState();
    getAllTodos();
  }

  getAllTodos() async {
    _recordService = RecordService();
    _recordList = <Record>[];

    var todos = await _recordService.readRecords();

    todos.forEach((todo) {
      setState(() {
        var model = Record();
        model.id = todo['id'];
        model.task = todo['task'];
        model.tag = todo['tag'];
        model.date = todo['date'];
        model.fromDate = todo['fromDate'];
        model.toDate = todo['toDate'];
        _recordList.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => RecordScreen()))
            .then((value) {
          setState(() {
            getAllTodos();
            
          });
        }),

        child: Icon(Icons.add),
        backgroundColor: const Color(0xFF151026),
      ),
      appBar: AppBar(
        title: Text('Next'),
      ),
      body: ListView.builder(
        itemCount: _recordList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_recordList[index].task ?? 'No Title'),
                  ],
                ),
                subtitle: Text(_recordList[index].tag ?? 'No Tag'),
                trailing: Text(_recordList[index].date ?? 'No Date'),
              ),
            ),
          );
        },
      ),
    );
  }
}
