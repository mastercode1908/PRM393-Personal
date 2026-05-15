void main() {
  // List
  List<int> numbers = [1, 2, 3, 4];

  // Add and remove
  numbers.add(5);
  numbers.remove(2);

  print("List: $numbers");
  print("First number: ${numbers[0]}");

  int a = 10;
  int b = 5;

  print("a + b = ${a + b}");
  print("a - b = ${a - b}");
  print("a == b : ${a == b}");
  print("a > b && b > 0 : ${a > b && b > 0}");

  String result = a > b ? "a is bigger" : "b is bigger";
  print(result);

  // Set (unique)
  Set<String> fruits = {"Apple", "Banana", "Apple"};
  fruits.add("Orange");

  print("Set: $fruits");

  // Map
  Map<String, int> scores = {"Math": 9, "English": 8};

  print("Math score: ${scores["Math"]}");
}
