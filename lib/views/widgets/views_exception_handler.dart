import 'package:emumba_test/view_models/app_states.dart';
import 'package:flutter/material.dart';
import 'app_snack_bar.dart';

errorHandler({required BuildContext context, required AppState state}) {
  if (state is UnknownErrorState) {
    showCustomSnackBar(
      context,
      state.error ?? '',
    );
  }
}
