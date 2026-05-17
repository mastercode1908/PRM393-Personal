class Box<T> {
  T value;

  Box(this.value);

  void show() {
    print("Value: $value");
  }
}

class Pair<K, V> {
  K key;
  V value;

  Pair(this.key, this.value);

  void display() {
    print("$key : $value");
  }
}

void main() {
  Box<int> numberBox = Box<int>(100);
  Box<String> textBox = Box<String>("Hello Dart");

  numberBox.show();
  textBox.show();

  Pair<String, int> student = Pair("Tuấn", 20);

  student.display();
}
