class Car {
  String? _brand;

  Car(this._brand);

  void start() {
    print("Started: $_brand");
  }
}

class Point {
  int x, y;
  Point(this.x, this.y);
  Point.origin() : x = 0, y = 0;
}

void main() {
  var c = Car("Test");
  c.start();

  var p = Point.origin();
}
