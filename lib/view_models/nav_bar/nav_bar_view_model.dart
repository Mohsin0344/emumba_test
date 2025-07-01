import 'package:bloc/bloc.dart';


class NavBarViewModel extends Cubit<int> {
  NavBarViewModel() : super(0);

  changeTap({
    required int tabIndex,
  }) async {
    emit(tabIndex);
  }
}
