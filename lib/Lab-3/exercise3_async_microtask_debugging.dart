import 'dart:async';

void main() {
  print('1. Main chay');

  // Cho vao microtask queue
  scheduleMicrotask(() {
    print('3. Microtask chay');
  });

  // Cho vao event queue
  Future(() {
    print('4. Future event chay');
  });

  print('2. Main ket thuc');
}

/*
KQ:
1. Main chay
2. Main ket thuc
3. Microtask chay
4. Future event chay

Giai thich:
- Code dong bo chay trc.
- Sau do Dart xu li microtask queue.
- Cuoi cung xu li event queue.
*/
