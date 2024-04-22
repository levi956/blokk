class BaseState<T> {
  const BaseState();
}

class Initial<T> extends BaseState<T> {}

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
