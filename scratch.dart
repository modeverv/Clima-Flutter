void main() {
  performTasks();
}

void performTasks() async {
  task1();
  String result = await task2();
  task1();
  task3(result);
  final results = await Future.wait([
    task2(),
    task2(),
    task2(),
    task2(),
  ]);
  print(results);
}

void task1() {
  String result = 'task 1 data';
  print('Task 1 complete');
}

Future<String> task2() async {
  String result;
  Duration sec3 = Duration(seconds: 3);
  await Future.delayed(sec3, () {
    result = 'task 2 data';
    print('Task 2 complete');
  });
  return result;
}

void task3(String data2) {
  String result = 'task 3 data';
  print('Task 3 complete $data2');
}
