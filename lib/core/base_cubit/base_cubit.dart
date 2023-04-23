import 'package:flutter_bloc/flutter_bloc.dart';

import '../base_usecase/failure.dart';
import 'base_state.dart';

abstract class BaseCubit extends Cubit<BaseState> {
  BaseCubit(BaseState state) : super(state);

  void handleFailure(Failure failure) {
    if (failure is InternetFailure) {
      emit(NoInternetState());
    } else if (failure is ApiFailure) {
      emit(FailedState(failure.message));
    }
  }
}
