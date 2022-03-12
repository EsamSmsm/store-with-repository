part of 'app_cubit.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppInitial extends AppState {}

class AppLoading extends AppState {}

class AppSuccess extends AppState {}

class AppFailed extends AppState {
  final String error;
  const AppFailed({
    required this.error,
  });
}

class ChangeLanguageLoading extends AppState {}

class ChangeLanguageSuccess extends AppState {}

class ChangeLanguageFailed extends AppState {
  final String error;
  const ChangeLanguageFailed({
    required this.error,
  });
}


