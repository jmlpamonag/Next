import 'package:next/model/record.dart';
import 'package:next/helpers/repository.dart';

class RecordService {
  Repository _repository;

  RecordService() {
    _repository = Repository();
  }

  saveRecord(Record record) async {
    return await _repository.insertData('record', record.recordMap());
  }

  //read todos
  readRecords() async {
    return await _repository.readData('record');
  }

}
