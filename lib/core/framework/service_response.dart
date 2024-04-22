import 'package:bloc_arch/core/framework/base_state.dart';

class ServiceResponse<T> {
  String? message;
  bool error;
  T? data;

  ServiceResponse({this.data, this.message, required this.error});

  BaseState<T> toBaseState() {
    return error
        ? Error(Exception(message ?? "An error occurred"))
        : Fetched<T>(data as T);
  }
}

ServiceResponse<T> serveError<T>({required String error}) {
  return ServiceResponse<T>(
    error: true,
    message: error,
  );
}

ServiceResponse<T> serveData<T>({required T? value, String? message}) {
  return ServiceResponse<T>(
    error: false,
    data: value,
    message: message,
  );
}

typedef MainFunction<Response> = Future<ServiceResponse<Response>> Function();

Future<ServiceResponse<T>> serveFuture<T>({
  required Future<T> Function(Fail fail) function,
  String Function(Object e)? handleError,
  String Function(T response)? handleData,
}) async {
  try {
    final T response = await function(_fail);
    String? message;
    if (handleData != null) {
      message = handleData(response);
    }
    return serveData<T>(value: response, message: message);
  } on ServeException catch (e) {
    return serveError<T>(error: e.message);
  } catch (e) {
    String error = handleError == null ? e.toString() : handleError(e);
    return serveError<T>(error: error);
  }
}

class ServeException implements Exception {
  late final String message;
  ServeException(this.message);
}

typedef Fail = Function(String message);

Never _fail(String message) => throw ServeException(message);

typedef FutureResponse<T> = Future<ServiceResponse<T>>;
