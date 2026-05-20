class Settings {
  // static variable
  static final Settings _instance = Settings._internal();

  String theme = 'Dark Mode';

  Settings._internal();

  factory Settings() {
    return _instance;
  }

  @override
  String toString() {
    return 'Settings(theme: $theme)';
  }
}

void main() {
  final a = Settings();
  final b = Settings();

  print(a);
  print(b);

  // identical() check 2 bien co cung tham chieu 1 bo nho k
  print('Hai instance co giong nhau k? ${identical(a, b)}');
}
