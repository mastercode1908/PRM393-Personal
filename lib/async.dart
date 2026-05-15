Future<String> fetch() async {
  await Future.delayed(Duration(seconds: 1));
  return "Done";
}

void main() async {
  print(await fetch());
}
