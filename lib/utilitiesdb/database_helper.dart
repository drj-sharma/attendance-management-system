
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
    await db.execute('CREATE TABLE attendence($rollNo INTEGER PRIMARY KEY, $attendence INTEGER)');
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
  Future<int> insertStudent(StudentInterface student) async {
    Database db = await this.database;
    var result;
    try {
      result = await db.insert(tableName, student.toMap());

      print('--->');
      print('result $result');
      return result;
    } catch (e) {
      print ('error $e');
      result = 404;   // man made error return statement, lol
    }
    return result;
  }

  // insert op
  Future<int> insertAttendence(AttendenceInterface attendence) async {
    Database db = await this.database;
    var result;
    try {
      result = await db.insert('attendence', attendence.toMap());
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
    return studentList;
}


  // retrieve data
  Future<List<AttendenceInterface>> getAttendence() async {
    final db = await database;
    var attendences = await db.rawQuery('SELECT * FROM attendence ORDER BY $rollNo');
    print(attendences);
    List<AttendenceInterface> attendenceList = List<AttendenceInterface>();
    attendences.forEach((currentAttendence) {
      AttendenceInterface attendence = AttendenceInterface.fromMap(currentAttendence);
      attendenceList.add(attendence);
    });
    print('ds');
    print(attendences);
    return attendenceList;
  }

// to get all tables list, same as show tables;
//  SELECT name FROM sqlite_master WHERE type='table'"


}