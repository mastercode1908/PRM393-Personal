// Async
Future<void> loadData() async {
  print("Loading...");

  // Delay
  await Future.delayed(Duration(seconds: 2));

  print("Data loaded");
}

void main() async {
  print("Start");

  await loadData();

  String? name;

  print(name ?? "No name");

  print(name?.length);

  // !
  String? city = "Hanoi";
  print(city!.toUpperCase());

  // Stream
  Stream<int> numberStream = Stream.fromIterable([1, 2, 3, 4]);

  numberStream.listen((number) {
    print("Value: $number");
  });

  print("End");
}
