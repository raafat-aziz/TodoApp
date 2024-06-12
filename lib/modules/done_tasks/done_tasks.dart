import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_revision_todo/shared/components/components.dart';
import 'package:new_revision_todo/shared/cubit/cubit.dart';
import 'package:new_revision_todo/shared/cubit/statues.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, index) {
          AppCubit cubit = AppCubit.get(context);
          return buildNoTasks(tasks: cubit.doneTasks);
        },
        listener: (context, index) {});
  }
}
