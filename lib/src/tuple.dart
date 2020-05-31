class Tuple<T1, T2> {
  final T1 item1;
  final T2 item2;

  const Tuple(this.item1, this.item2);

  @override
  String toString() => '[$item1, $item2]';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Tuple &&
          runtimeType == other.runtimeType &&
          item1 == other.item1 &&
          item2 == other.item2;

  @override
  int get hashCode => item1.hashCode ^ item2.hashCode;
}
