import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'app_states.dart';

class TestViewModel extends Cubit<AppState> {
  TestViewModel() : super(const InitialState());
}
