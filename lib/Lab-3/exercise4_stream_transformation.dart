Future<void> main() async {
  print('Stream Tranformation');

  // Tao stram tu 1 den 5
  final stream = Stream.fromIterable([1, 2, 3, 4, 5]);

  final transformedStream = stream
      .map((number) => number * number)
      .where((square) => square % 2 == 0);

  await for (var value in transformedStream) {
    print('Gia tri nhan dc: $value');
  }
}
