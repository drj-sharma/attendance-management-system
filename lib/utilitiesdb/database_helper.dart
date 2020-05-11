
import 'package:sqflite/sqflite.dart';
import 'dart:async';
//import 'dart:io';
//import 'package:path_provider/path_provider.dart';
import 'package:attendencemanagementsystem/models/student_interface.dart';


class DatabaseHelper {
  static DatabaseHelper _databaseHelper;// singleton object means, instantiate only one time in the lifetime of app
  static Database _database;

  String tableName = 'Students';
  static const String rollNo = 'rollNo';
  static const String name = 'name';
  static const String attendence = 'attendence';
  static const String email = 'email';
  static const String password = 'password';
  static const String favques = 'favques';

  DatabaseHelper._createInstance(); // named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {

    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // GET the directory path for both android and ios to store db
    String directory = await getDatabasesPath();
    String dbPath = directory + 'studentDB.db';

    // open/create the db at a given directory
    var studentsDb = await openDatabase(dbPath, version: 1, onCreate: _createDb);
    return studentsDb;
  }
  void _createDb(Database db, int newVersion) async {
    print('Database created');
    await db.execute('CREATE TABLE $tableName($rollNo INTEGER PRIMARY KEY, $name TEXT)');
    await db.execute('CREATE TABLE attendence($rollNo INTEGER PRIMARY KEY)');
    await db.execute('CREATE TABLE teacher($email TEXT UNIQUE PRIMARY KEY NOT NULL, $name TEXT NOT NULL, $favques TEXT NOT NULL, $password TEXT NOT NULL)');
  }
  void createDBb() async {
    final db = await database;
    await db.execute('''
   create table abcd (
    jkds integer primary key autoincrement,
    dslk text not null
   )''');
    await db.execute('''
   create table dios(
    djsk integer primary key autoincrement,
    jdls text not null
   )''');
  }


  // insert op
  Future<int> insertStudent(StudentInterface student, String rollno) async {
    Database db = await this.database;
    var result, result2;
    try {
      int newrollno = int.parse(rollno);
      result = await db.insert(tableName, student.toMap());
      result2 = await db.rawQuery('INSERT INTO attendence(rollNo) VALUES($newrollno);');
      print(result2);
      print('--->');
      print('result $result');
      return result;
    } catch (e) {
      result = 404;   // man made error return statement, lol
      print(e);
    }
    return result;
  }

  // insert op
  Future<int> insertAndUpdateAttendence(AttendenceInterface attendence, String columnName) async {
    Database db = await this.database;
    var result;
    try {
      String columnName2 = '`$columnName`';
      result = await db.rawQuery("UPDATE attendence SET $columnName2 = ${attendence.attendence} WHERE $rollNo = ${attendence.rollNo};");
      print('--->');
      print('result $result');
      return result;
    } catch (e) {
      print ('error $e');
      result = 404;   // man made error return statement, lol
    }
    return result;
  }

  // insert op\
//  Future<int> updateNote(StudentInterface student) async {
//    Database db = await this.database;
//
//  }
  // retrieve data
Future<List<StudentInterface>> getStudents() async {
    try {
      final db = await database;
      var students = await db.rawQuery('SELECT * FROM $tableName ORDER BY $rollNo');
      print(students);
      List<StudentInterface> studentList = List<StudentInterface>();
      students.forEach((currentStudent) {
        StudentInterface student = StudentInterface.fromMap(currentStudent);
        studentList.add(student);
      });
      print('ds');
      print(students);
      return studentList??[];
    } catch (e) {
      print(e);
    }
}


  // retrieve data
  Future<List<Map<String, dynamic>>> getAttendence() async {
    final db = await database;
    try {
      List<Map<String, dynamic>> attendences = await db.rawQuery('SELECT name FROM PRAGMA_TABLE_INFO("attendence") WHERE name <> "rollNo" ORDER BY name DESC;');
      print(attendences);

      return attendences;
    } catch (e) {
      print(e);
    }
  }



//  void insertcolumn()
// to get all tables list, same as show tables;
//  SELECT name FROM sqlite_master WHERE type='table'"

  // to get all columns
// 'SELECT name FROM PRAGMA_TABLE_INFO("teacher");'

// teacher table ops
  // insert op
  Future<int> insertTeacher(TeacherInterface teacher) async {
    Database db = await this.database;
    var result;
    try {
      result = await db.insert('teacher', teacher.toMap());

      print('--->');
      print('result $result');
      return result;
    } catch (e) {
      result = 404;   // man made error return statement, lol
    }
    return result;
  }

  Future<List<TeacherInterface>> getTeachers() async {
    final db = await database;
    var teacher = await db.rawQuery('SELECT * FROM teacher');
    print(teacher);
  }

  Future<int> login(String uEmail, String uPassword) async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM teacher WHERE $email='$uEmail'");
    print(res);
    if (res.length > 0) {
      return 1;
    } else {
      return 0;
    }
  }

  Future<dynamic> addNewColumn(String columnName) async {
    try {
      final db = await database;
      columnName = '`$columnName`';
      var res = await db.rawQuery("ALTER TABLE attendence ADD COLUMN $columnName INTEGER DEFAULT (0)");
      print('ad');
      print(res);
      return res;
    }
   catch (e) {
     print(e);
   }
  }

  Future<List<Map<String, dynamic>>> getStudentsAttendenceByLectureTime(String colName) async {
    try {
      print("-->$colName");
      final db = await database;
      var colName2 = '`$colName`';
//      var res = await db.rawQuery("SELECT $rollNo, $colName2 as atn from attendence ORDER BY $rollNo;");
      var res = await db.rawQuery("select Students.name as name,  attendence.rollNo as rollNo, attendence.$colName2 as atn from Students left join attendence using(rollNo) ORDER BY Students.rollNo asc;");
      print("list->$res");
      return res;
    } catch (e) {
      print(e);
    }
  }
  // retrieve data
  Future<List<Map<String, dynamic>>> getRollNo() async {
    final db = await database;
    try {
      List<Map<String, dynamic>> attendences = await db.rawQuery('select Students.name as name,  attendence.rollNo as rollNo from Students left join attendence using(rollNo) ORDER BY Students.rollNo asc;"');
      print(attendences);

      return attendences;
    } catch (e) {
      print(e);
    }
  }

// attendence-report
  Future<List<Map<String, dynamic>>> getReportTillNow(String rollno) async {
    try {
      final db = await database;
//      var res = await db.rawQuery("SELECT $rollNo, $colName2 as atn from attendence ORDER BY $rollNo;");
      var res = await db.rawQuery(
          'SELECT COUNT(name) as count FROM PRAGMA_TABLE_INFO("attendence") WHERE name <> "rollNo";');
      var res3 = await db.rawQuery(
          'SELECT name FROM PRAGMA_TABLE_INFO("attendence") WHERE name <> "rollNo" ORDER BY name DESC;');
      StringBuffer values = new StringBuffer();
      StringBuffer values2 = new StringBuffer();
      var resval;
      res3.forEach((item) {
        item.forEach((k, v) {
          print(v);
          resval = '$v';
          values2.write('`$v`');
          values2.write(',');   // added inbuild like ',' sign
          values.write('`$v`');
          values.write('+');    // added inbuild like '+' sign lmao to sum
        });
      });

      int vallen = values.length;
      int vallen2 = values2.length;
      print(vallen);
      String newValues = values.toString().substring(0, vallen-1);
      String newValues2 = values.toString().substring(0, vallen2-1);
      print('-----');
      print(newValues.length);


      print ("values--> $values");
      var res2 = await db.rawQuery('SELECT $newValues as "Total" FROM attendence where rollNo=$rollno;');

      print(res);
      print("RES3 $res3");
      print("columns--> $res2");
//      var value = int.parse(res[0]["count"])/int.parse(res2[0]["Total"]);
      List<Map<String, dynamic>> result = res + res2;
      return result;
    } catch (e) {
      print(e);
    }
  }
}
