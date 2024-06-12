import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:new_revision_todo/layout/home_layout.dart';
import 'package:new_revision_todo/modules/new_tasks/new_tasks.dart';
import 'package:flutter/src/rendering/box.dart';
import 'package:new_revision_todo/shared/cubit/cubit.dart';

Widget defaultFormField({
  required FormFieldValidator<String> validate,
  required TextEditingController controller,
  required String label,
  required Icon prefix,
  GestureTapCallback? onTap,
  TextInputType? type,
}) {
  return TextFormField(
    keyboardType: type,
    onTap: onTap,
    validator: validate,
    controller: controller,
    decoration: InputDecoration(
        prefixIcon: prefix,
        labelText: label,
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(20.0)))),
  );
}

Widget buildTaskScreen(
    Map model,
// الماب عبارة عن
//key و value
// فأنا كتبتها هنا عشان تاخد كل عنصر موجود جوه
// الليست الكبيرة اللى فيها كذا ماب
// عشان تعرضلى كل عنصر لوحده
// عشان لو عملتها على الليست الكبيرة مش هيقدر ياخد كل عنصر لوحده
// وهياخد كل العناصر مجمعه فى عنصر واحد وده مش هينفع يحصل أصلا
    BuildContext context) {
  return Dismissible(
    key: Key(model['id'].toString()),
    onDismissed: (direction) {
      AppCubit.get(context).deleteFromDatabase(model['id']);
    },
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(children: [
        CircleAvatar(
          backgroundColor: Colors.green,
          radius: 50.0,
          child: Text(
            '${model['time']}',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            children: [
              Text(
                '${model['title']}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                '${model['date']}',
                style: TextStyle(color: Colors.grey, fontSize: 16.0),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateDataBase(status: 'done', id: model['id']);
              },
              icon: Icon(Icons.check_box),
              color: Colors.green,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateDataBase(status: 'archived', id: model['id']);
              },
              icon: Icon(Icons.archive),
              color: Colors.black45,
            ),
          ],
        )
      ]),
    ),
  );
}

Widget buildNoTasks({
  required List<Map> tasks,
}) {
  return ConditionalBuilder(
    condition: tasks.length > 0,
    builder: (context) {
      return ListView.separated(
          // shrinkWrap: true,
          itemBuilder: (context, index) =>
              buildTaskScreen(tasks[index], context),
          separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.black54,
                ),
              ),
          itemCount: tasks.length);
    },
    fallback: (context) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.task,
              size: 50.0,
              color: Colors.black45,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'There is no tasks yet , please add some tasks',
              style: TextStyle(
                  color: Colors.black45,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    },
  );
}

// Widget buildTasks({required List<Map> tasks}) {
//   return ListView.separated(
//       // shrinkWrap: true,
//       itemBuilder: (context, index) {
//         return Expanded(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               buildTaskScreen(tasks[index], context),
//             ],
//           ),
//         );
//       },
//       separatorBuilder: (context, index) {
//         return Divider(
//           color: Colors.grey,
//           height: 1.0,
//         );
//       },
//       itemCount: tasks.length);
// }
