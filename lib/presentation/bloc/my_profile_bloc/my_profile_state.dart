part of 'my_profile_bloc.dart';

@immutable
sealed class MyProfileState {}

final class MyProfileInitial extends MyProfileState {}

class MyProfileLoadingState extends MyProfileState {}

class MyProfileLoadedState extends MyProfileState {}

class MyProfileErrorState extends MyProfileState {}
