import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';


class NavBarViewModel extends Cubit<int> {
  NavBarViewModel() : super(0);

  List navBarItemTitles = [
    'List View',
    'Calendar View',
  ];

  List navBarIcons = [
    Icons.list,
    Icons.calendar_month,
  ];

  changeTap({
    required int tabIndex,
  }) async {
    emit(tabIndex);
  }
}
