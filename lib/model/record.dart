class Record {
  int id;
  String task;
  String tag;
  String date;
  String fromDate;
  String toDate;

  todoMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['task'] = task;
    mapping['tag'] = tag;
    mapping['date'] = date;
    mapping['fromDate'] = fromDate;
    mapping['toDate'] = toDate;
    
    return mapping;
  }
}
