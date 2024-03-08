part of 'my_profile_bloc.dart';

@immutable
abstract class MyProfileEvent {}


class LoadMyProfileEvent extends MyProfileEvent {}

class MyProfileInitialEvent extends MyProfileEvent {}

class MyProfileLoadedEvent extends MyProfileEvent {}
