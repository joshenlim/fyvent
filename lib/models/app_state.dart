import 'package:fyvent/models/user.dart';

/// This file essentially gives your flutter app a Redux
/// functionality, enabling your app to have a single
/// state tree in which all your screens can have access to
/// Simple import AppStateContainer and have the declaration:
/// var container = AppStateContainer.of(context);
/// AppState appState = container.state;

class AppState {
  bool isLoading;
  User user;

  // Constructor
  AppState({
    this.isLoading = false,
    this.user,
  });

  // A constructor for when the app is loading.
  factory AppState.loading() => new AppState(isLoading: true);

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, user: ${'joshen user'}}';
  }
}