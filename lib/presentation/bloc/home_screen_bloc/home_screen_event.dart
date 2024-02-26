part of 'home_screen_bloc.dart';

@immutable
abstract class HomeScreenEvent {}

class NavigateToHomeTabEvent extends HomeScreenEvent {}

class NavigateToLearnTabEvent extends HomeScreenEvent {}

class NavigateToEarnTabEvent extends HomeScreenEvent {}

class NavigateToMyContactsTabEvent extends HomeScreenEvent {}

class NavigateToMyProfileEvent extends HomeScreenEvent {}

class NavigateToRewardPointsEvent extends HomeScreenEvent {}

class NavigateToWithdrawlsEvent extends HomeScreenEvent {}

class NavigateToPrivacyPolicyEvent extends HomeScreenEvent {}
