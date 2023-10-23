import 'package:bloc_arch/core/framework/service_response.dart';

class SomethingService {
  static Future<ServiceResponse<String>> fetchData() {
    return serveFuture<String>(
      function: (fail) async {
        await Future.delayed(const Duration(seconds: 4));
        return 'This is quick data';
      },
    );
  }
}
