import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'top_contributor_event.dart';
part 'top_contributor_state.dart';

class TopContributorBloc extends Bloc<TopContributorEvent, TopContributorState> {
  TopContributorBloc() : super(TopContributorInitial()) {
    
  }
}
