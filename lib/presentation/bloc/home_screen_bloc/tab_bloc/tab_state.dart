part of 'tab_bloc.dart';


abstract class TabState{
 final int tabIndex;
 TabState({required this.tabIndex});
}

class TabInitial extends TabState{
  TabInitial({required super.tabIndex});
}