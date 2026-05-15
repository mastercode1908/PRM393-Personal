void main() {
  for (int i = 0; i < 3;) {
    print(i++);
  }

  for (int i = 0; i <= 3; i++) {
    print("Test $i");
  }

  List<String> jobs = ["!", "ok"];

  jobs.add("Test");
  jobs.add("Code");
  jobs.remove("Test");
  print(jobs);

  String name = "Chu The Duc";
  print("Hello $name");
  print("Length ${name.length}");

  var day = "Mon";
  switch (day) {
    case "Mon":
      print("Ok");
      break;
    default:
      print("Other");
  }

  int add(int a, int b) => a + b;
  print(add(2, 3));

  void greet({String name = "Duc"}) {
    print(name);
  }

  greet();

  final numbers = [1, 2, 3, 4, 5];
  final squares = numbers.map((n) => n * 2);
  final isEven = numbers.where((n) => n.isEven);
  final big = numbers.map((n) => n * 2).where((n) => n > 6);
  final labels = numbers.map((n) => 'Item $n').toList();

  print(squares.toList());
  print(isEven.toList());
  print(big.toList());
  print(labels.toList());
}
