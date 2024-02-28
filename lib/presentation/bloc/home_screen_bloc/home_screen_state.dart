part of 'home_screen_bloc.dart';

@immutable
abstract class HomeScreenState {}

class DrawerTabChangeState extends HomeScreenState {
  final int tabIndex;
  DrawerTabChangeState({required this.tabIndex});
}

abstract class HomeScreenActionState extends HomeScreenState {}

class HomeScreenInitialState extends HomeScreenState {}

class HomeScreenLoadingState extends HomeScreenState {}

class HomeScreenLoadedState extends HomeScreenState {}

class HomeScreenErrorState extends HomeScreenState {}

class NavigateToHomeTabState extends HomeScreenActionState {}

class NavigateToLearnTabState extends HomeScreenActionState {}

class NavigateToEarnTabState extends HomeScreenActionState {}

class NavigateToMyConnectsTabState extends HomeScreenActionState {}

class NavigateToWithdrawlsState extends HomeScreenActionState {}

class NavigateToRewardPointsState extends HomeScreenActionState {}

class NavigateToPrivacyPolicyState extends HomeScreenActionState {}

class NavigateToMyCoursesState extends HomeScreenActionState {}

class NavigateToMyProfileState extends HomeScreenActionState {}

class HomeScreenLogoutState extends HomeScreenActionState {}
