import 'package:attendencemanagementsystem/utilitiesdb/database_helper.dart';

class StudentInterface {
  String name;
  int rollNo;
  StudentInterface({this.name, this.rollNo});


  Map<String, dynamic> toMap() {
      var map = <String, dynamic>{
      DatabaseHelper.name: name,
      DatabaseHelper.rollNo: rollNo,
    };
      return map;
  }

  StudentInterface.fromMap(Map<String , dynamic> map) {
    rollNo = map[DatabaseHelper.rollNo];
    name = map[DatabaseHelper.name];
    print(name);
  }
}

class AttendenceInterface {
  int attendence;
  int rollNo;
  AttendenceInterface({this.rollNo, this.attendence});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseHelper.attendence: attendence,
      DatabaseHelper.rollNo: rollNo,
    };
    return map;
  }

  AttendenceInterface.fromMap(Map<String , dynamic> map) {
    rollNo = map[DatabaseHelper.rollNo];
    attendence = map[DatabaseHelper.attendence];
    print(attendence);
  }
}