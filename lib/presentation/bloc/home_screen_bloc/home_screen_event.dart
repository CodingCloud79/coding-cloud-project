part of 'home_screen_bloc.dart';

@immutable
abstract class HomeScreenEvent {}

class NavigateToHomeTabEvent extends HomeScreenEvent {}

class DrawerTabChangeEvent extends HomeScreenEvent{
  final int tabIndex;
  DrawerTabChangeEvent({ required this.tabIndex});
}
class NavigateToLearnTabEvent extends HomeScreenEvent {}

class NavigateToEarnTabEvent extends HomeScreenEvent {}

class NavigateToMyConnectsTabEvent extends HomeScreenEvent {}

class NavigateToMyProfileEvent extends HomeScreenEvent {}

class NavigateToRewardPointsEvent extends HomeScreenEvent {}

class NavigateToWithdrawlsEvent extends HomeScreenEvent {}

class NavigateToMyCoursesEvent extends HomeScreenEvent {}

class NavigateToPrivacyPolicyEvent extends HomeScreenEvent {}

class HomeScreenLogoutEvent extends HomeScreenEvent {}
