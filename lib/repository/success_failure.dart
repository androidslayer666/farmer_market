abstract class Result<T>{}

class Success<T> extends Result<T>{
  Success({required this.data});

  T? data;
}

class Failure<T> extends Result<T> {
  Failure({required this.data});

  T? data;
}