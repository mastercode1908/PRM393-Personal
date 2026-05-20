void main() {
  int score = 75;

  // if/else
  if (score >= 80) {
    print("Excellent");
  } else if (score >= 50) {
    print("Passed");
  } else {
    print("Failed");
  }

  // switch
  String day = "Monday";

  switch (day) {
    case "Monday":
      print("Start week");
      break;
    case "Friday":
      print("Weekend is near");
      break;
    default:
      print("Normal");
  }

  // loop
  for (int i = 1; i <= 3; i++) {
    print("i = $i");
  }

  // for-in loop
  List<String> names = ["An", "Binh", "Duc"];

  for (String name in names) {
    print("Hello $name");
  }

  // forEach
  names.forEach((name) {
    print("forEach: $name");
  });

  print(add(3, 4));
  print(square(5));
}

int add(int a, int b) {
  return a + b;
}

int square(int x) => x * x;
