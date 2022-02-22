abstract class Result<T,E>{}

class Success<T,E> extends Result<T,E>{
  Success({this.data});

  T? data;
}

class Failure<T,E> extends Result<T,E> {
  Failure({this.error});

  E? error;
}