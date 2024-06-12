import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_revision_todo/modules/archived_tasks/archived_tasks.dart';
import 'package:new_revision_todo/modules/done_tasks/done_tasks.dart';
import 'package:new_revision_todo/modules/new_tasks/new_tasks.dart';
import 'package:new_revision_todo/shared/cubit/statues.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  bool isSheetShown = false;
  IconData fabIcon = Icons.edit;
  // List<Map<String, dynamic>> tasks = [];
  List<Map<String, dynamic>> newTasks = [];
  List<Map<String, dynamic>> doneTasks = [];
  List<Map<String, dynamic>> archivedTasks = [];

  var currentIndex = 0;

  List<String> titles = ['New Tasks', 'Done Tasks', 'Archived Tasks'];
  Database? database;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];

  void changeIconButton({required IconData icon, required bool isShown}) {
    fabIcon = icon;
    isSheetShown = isShown;
    emit(ChangeIconFloatingAction());
  }

  void bottomNavBar(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }

  Future<void> createDataBase() async {
    database = await openDatabase('todo.db', version: 1,
        onCreate: (database, version) {
      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, time TEXT, date TEXT, status TEXT)')
          .then((value) {
        print('Table Created');
      }).catchError((error) {
        print('Error creating table: $error');
      });
      print('DataBase Created');
    }, onOpen: (database) {
      print('DataBase Opened');
      getDataBase(database);
    });
  }

  void insertToDatabase({
    required String title,
    required String time,
    required String date,
    required String status,
  }) {
    database!.transaction((txn) {
      return txn
          .rawInsert(
        'INSERT INTO tasks(title, time, date, status) VALUES("$title", "$time", "$date", "OK")',
      )
          .then((value) {
        print('$value Inserted Successfully');
        emit(InsertToDataBaseStatues());
        getDataBase(database!);
      }).catchError((error) {
        print('Error inserting to database: $error');
      });
    });
  }

  void getDataBase(Database database) {
    database.rawQuery('SELECT * FROM tasks').then((value) {
      // tasks = value;
      // print(tasks);
      newTasks = [];
      doneTasks = [];
      archivedTasks = [];
      // لازم هنا أصفر  المتغيرات اللى
      //هتاخد القيم عشان ميحطش داتا على اللى موجود
      // وميحصلش أننا نلاقى داتا بتتحط على القديم
      value.forEach((element) {
        if (element['status'] == 'OK') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      });
      emit(GetFromDataBaseStatues());
    }).catchError((error) {
      print('Error getting data from database: $error');
    });
  }

  void updateDataBase({
    required String status,
    required int id,
  }) {
    database!.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?', [status, id]).then((value) {
      print('Data updated successfully');
      emit(UpdateDataBaseStatues());
      getDataBase(database!);
    }).catchError((error) {
      print('Error updating data: $error');
    });
  }

  void deleteFromDatabase(int id) {
    database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      emit(DeleteFromDataBaseStatues());
      print('Data Deleted Successfully');
      getDataBase(database!);
    });
  }
}
