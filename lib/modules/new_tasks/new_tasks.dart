import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_revision_todo/layout/home_layout.dart';
import 'package:new_revision_todo/shared/components/components.dart';
import 'package:new_revision_todo/shared/cubit/cubit.dart';
import 'package:new_revision_todo/shared/cubit/statues.dart';

class NewTasksScreen extends StatelessWidget {
  const NewTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, index) {},
      builder: (context, index) {
        AppCubit cubit = AppCubit.get(context);
        // List<Map<String, dynamic>> task = cubit.tasks;
        List<Map<String, dynamic>> newTask = cubit.newTasks;
        /*
         هنا خليت تاسك 
         List<Map<String, dynamic>>
         بدل var
         عشان أقدر أستدعيها من غير مشاكل 
          */
        return buildNoTasks(tasks: newTask);
      },
    );
  }
}

  /*  Column(
          // mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 50.0,
                  child: Text(
                    'Time',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0),
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Column(
                  children: [
                    Text(
                      'Title',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 40.0),
                    ),
                    Text('Date',
                        style: TextStyle(color: Colors.grey, fontSize: 20.0)),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 50.0,
                  child: Text(
                    'Time',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0),
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Column(
                  children: [
                    Text(
                      'Title',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 40.0),
                    ),
                    Text('Date',
                        style: TextStyle(color: Colors.grey, fontSize: 20.0)),
                  ],
                )
              ],
            ),
          ],
        ),*/
  //     ),
  //   );
  // }

  // static NewTasksScreen get(BuildContext context) {
  //   final widget = context.findAncestorWidgetOfExactType<NewTasksScreen>();
  //   if (widget == null) {
  //     throw Exception('Could not find NewTasksScreen in the widget tree');
  //   }
  //   return widget;
  // }

