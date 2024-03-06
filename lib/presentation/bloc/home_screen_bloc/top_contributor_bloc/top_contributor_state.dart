part of 'top_contributor_bloc.dart';

@immutable
sealed class TopContributorState {}

final class TopContributorInitial extends TopContributorState {}

class TopContributorLoadingState extends TopContributorState {}

class TopContributorLoadedState extends TopContributorState {}

class TopContributorErrorState extends TopContributorState {}
