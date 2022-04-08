class Pair<T1,T2> {
  final T1 first;
  final T2 second;
  Pair(this.first, this.second);

  @override
  bool operator == (dynamic other) {
    return first == other.first && second == other.second;
  }

  @override
  int get hashCode => super.hashCode;

}