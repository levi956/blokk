import 'package:bloc_arch/core/framework/service_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'base_state.dart';

class NoArsBaseCubit<T> extends Cubit<BaseState<T>> {
  NoArsBaseCubit({required MainFunction<T> function}) : super(const Init()) {
    _mainFunction = function;
  }

  MainFunction<T>? _mainFunction;

  Future<void> trigger() async {
    if (_mainFunction != null) {
      emit(const Loading());
      var response = await _mainFunction!();
      emit(response.toBaseState());
    } else {
      emit(Error(Exception('MainFunction is not provided')));
    }
  }

  Future<void> get() async {
    await trigger();
  }
}
