part of 'home_screen_bloc.dart';

@immutable
abstract class HomeScreenState {}

abstract class HomeScreenActionState extends HomeScreenState {}

class HomeScreenInitialState extends HomeScreenState {}

class HomeScreenLoadingState extends HomeScreenState {}

class HomeScreenLoadedState extends HomeScreenState {}

class HomeScreenErrorState extends HomeScreenState {}

class NavigateToHomeTabState extends HomeScreenActionState {}

class NavigateToLearnTabState extends HomeScreenActionState {}

class NavigateToEarnTabState extends HomeScreenActionState {}

class NavigateToMyContactsTabState extends HomeScreenActionState {}

class NavigateToWithdrawlsState extends HomeScreenActionState {}

class NavigateToRewardPointsState extends HomeScreenActionState {}

class NavigateToPrivacyPolicyState extends HomeScreenActionState {}

class NavigateToMyCoursesState extends HomeScreenActionState {}

class NavigateToMyProfileState extends HomeScreenActionState {}
