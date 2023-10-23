import 'package:bloc_arch/core/framework/service_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'base_state.dart';

class NoArsBaseCubit<T> extends Cubit<BaseState<T>> {
  NoArsBaseCubit({required MainFunction<T> function}) : super(const Init()) {
    trigger(function);
  }

  Future<void> trigger(MainFunction<T> f) async {
    emit(const Loading());
    var response = await f();
    emit(response.toBaseState());
  }
}
