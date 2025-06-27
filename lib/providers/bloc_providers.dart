import 'package:emumba_test/view_models/test_view_model_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProviders {
  static final List<BlocProvider> providers = [
    BlocProvider<TestViewModel>(
      create: (context) => TestViewModel(),
    )
  ];
}