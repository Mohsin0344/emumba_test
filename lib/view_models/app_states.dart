import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

@immutable
sealed class AppState {
  const AppState();
}

final class InitialState extends AppState {
  const InitialState();
}

final class LoadingState extends AppState {
  const LoadingState();
}

final class LoadingStateWithProgress extends AppState {
  final double progress;

  const LoadingStateWithProgress({
    required this.progress,
  });
}

final class SuccessState<T> extends AppState {
  final T data;

  const SuccessState({
    required this.data,
  });
}

final class ErrorState extends AppState {
  final String? error;

  const ErrorState({this.error});
}

final class TimeoutState extends AppState {
  const TimeoutState();
}

final class InternetErrorState extends AppState {
  const InternetErrorState();
}

final class VersionErrorState extends AppState {
  const VersionErrorState();
}

final class FaceVerificationFailed extends AppState {
  const FaceVerificationFailed();
}

final class InterestsNotFound extends AppState {
  const InterestsNotFound();
}

final class UserImageNotFound extends AppState {
  const UserImageNotFound();
}

final class UnknownErrorState extends AppState {
  final String? error;

  const UnknownErrorState({this.error});
}

final class PermissionPermanentlyDeniedState extends AppState {
  const PermissionPermanentlyDeniedState();
}


final class AccessDeniedError extends AppState {
  const AccessDeniedError();
}


