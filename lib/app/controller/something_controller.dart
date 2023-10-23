import 'package:bloc_arch/core/framework/base_cubit.dart';

import '../service/something_service.dart';

class SomethingController extends NoArsBaseCubit<String> {
  SomethingController() : super(function: SomethingService.fetchData);
}
