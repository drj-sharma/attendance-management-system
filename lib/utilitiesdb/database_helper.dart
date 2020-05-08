import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:attendencemanagementsystem/models/student_interface.dart';


class DatabaseHelper {
  static DatabaseHelper _databaseHelper;// singleton object means, instantiate only one time in the lifetime of app
  static Database _database;

  String tableName = 'Students';
  static const String rollNo = 'rollNo';
  static const String name = 'name';

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
  }


  // insert op
  Future<int> insertStudent(StudentInterface student) async {
    Database db = await this.database;
    var result = await db.insert(tableName, student.toMap());
    print('--->');
    print(result);
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
    List<StudentInterface> studentList = List<StudentInterface>();
    students.forEach((currentStudent) {
      StudentInterface student = StudentInterface.fromMap(currentStudent);
      studentList.add(student);
    });
  print('ds');
  print(students);
    return studentList;
}



}