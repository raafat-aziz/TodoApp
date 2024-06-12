import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_revision_todo/modules/archived_tasks/archived_tasks.dart';
import 'package:new_revision_todo/modules/done_tasks/done_tasks.dart';
import 'package:new_revision_todo/modules/new_tasks/new_tasks.dart';
import 'package:new_revision_todo/shared/components/components.dart';
import 'package:intl/intl.dart';
import 'package:new_revision_todo/shared/cubit/cubit.dart';
import 'package:new_revision_todo/shared/cubit/statues.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var titleController = TextEditingController();
    var dateController = TextEditingController();
    var timeController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    final scafolldKey = GlobalKey<ScaffoldState>();

    return BlocProvider(
        create: (context) => AppCubit()..createDataBase(),
        child: BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {},
            builder: (context, state) {
              AppCubit cubit = AppCubit.get(context);
              return Scaffold(
                key: scafolldKey,
                appBar: AppBar(
                  title: Text(
                    cubit.titles[cubit.currentIndex],
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  backgroundColor: Colors.green,
                ),
                floatingActionButton: FloatingActionButton(
                  child: Icon(cubit.fabIcon),
                  onPressed: () {
                    if (cubit.isSheetShown) {
                      if (formKey.currentState!.validate()) {
                        cubit.insertToDatabase(
                            title: titleController.text,
                            date: dateController.text,
                            time: timeController.text,
                            status: 'new');
                        Navigator.pop(context);
                        // setState(() {
                        // cubit.fabIcon = Icons.edit;
                        cubit.changeIconButton(
                            icon: Icons.edit, isShown: false);
                        // });
                      }
                      // cubit.isSheetShown = false;
                    } else {
                      scafolldKey.currentState!
                          .showBottomSheet((context) {
                            return Form(
                              key: formKey,
                              child: Container(
                                padding: EdgeInsets.all(20.0),
                                color: Colors.white,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    defaultFormField(
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'title must not be empty';
                                        }
                                      },
                                      controller: titleController,
                                      type: TextInputType.text,
                                      label: 'Write Your Title Task Here',
                                      prefix: Icon(Icons.title_outlined),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    defaultFormField(
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'date must not be empty';
                                          }
                                        },
                                        controller: dateController,
                                        type: TextInputType.datetime,
                                        label: 'Write Your Date Here',
                                        prefix:
                                            Icon(Icons.calendar_month_outlined),
                                        onTap: () {
                                          showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime.parse(
                                                      '2024-06-28'))
                                              .then((value) {
                                            dateController.text =
                                                DateFormat.yMMMd()
                                                    .format(value!);
                                          });
                                        }),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    defaultFormField(
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'Time must not be empty';
                                          }
                                        },
                                        controller: timeController,
                                        type: TextInputType.datetime,
                                        label: 'Write Your Time Task Here',
                                        prefix:
                                            Icon(Icons.watch_later_outlined),
                                        onTap: () {
                                          showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now())
                                              .then((value) {
                                            timeController.text = value!
                                                .format(context)
                                                .toString();
                                            print(value);
                                          });
                                        }),
                                  ],
                                ),
                              ),
                            );
                          })
                          .closed
                          .then((value) {
                            cubit.changeIconButton(
                                icon: Icons.edit, isShown: false);
                            // cubit.isSheetShown = false;
                            // // setState(() {
                            // cubit.fabIcon = Icons.edit;
                            // });
                          });
                      cubit.changeIconButton(icon: Icons.add, isShown: true);
                      // setState(() {
                      // cubit.fabIcon = Icons.add;
                      // // });
                      // cubit.isSheetShown = true;
                    }
                  },
                  backgroundColor: Colors.green,
                ),
                bottomNavigationBar: BottomNavigationBar(
                  selectedItemColor: Colors.green,
                  currentIndex: cubit.currentIndex,
                  onTap: (index) {
                    // setState(() {
                    cubit.bottomNavBar(index);
                    // });
                  },
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.add_task_sharp), label: 'Tasks'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.check_box_rounded), label: 'Done'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.archive_outlined), label: 'Archived')
                  ],
                ),
                body: cubit.screens[cubit.currentIndex],
              );
            }));
  }
}
