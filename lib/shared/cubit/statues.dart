import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AppStates {}

class InitialState extends AppStates {}

class ChangeIconFloatingAction extends AppStates {}

class ChangeBottomNavBarState extends AppStates {}

class InsertToDataBaseStatues extends AppStates {}

class GetFromDataBaseStatues extends AppStates {}

class UpdateDataBaseStatues extends AppStates {}

class DeleteFromDataBaseStatues extends AppStates {}
