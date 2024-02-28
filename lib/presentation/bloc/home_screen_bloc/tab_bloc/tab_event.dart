part of 'tab_bloc.dart';

@immutable
abstract class TabEvent{}

class TabChangeEvent extends TabEvent{
  final int tabIndex;
  TabChangeEvent({ required this.tabIndex});
}