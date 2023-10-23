class BaseState<T> {
  const BaseState();
}

class Init<T> extends BaseState<T> {
  const Init();
}

class Loading<T> extends BaseState<T> {
  const Loading();
}

class Error<T> extends BaseState<T> {
  final Exception error;

  Error(this.error);
}

class Fetched<T> extends BaseState<T> {
  final T data;

  Fetched(this.data);
}
