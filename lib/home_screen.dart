import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'home_screen.g.dart';

@riverpod
class Counter extends _$Counter {
  @override
  int build() => 0;

  void increment() {
    ++state;
  }
}

// a stateless widget for home screen
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var count = ref.watch(counterProvider);
    var counter = ref.read(counterProvider.notifier);
    var homeValue = ref.watch(homeControllerProvider);
    var homeValueController = ref.watch(homeControllerProvider.notifier);

    // a scafold for homescreen
    return Scaffold(
      // appbar
      appBar: AppBar(
        // title
        title: const Text('Home Screen'),
      ),
      // body
      body: Center(
        // a column
        child: Column(
          // center align
          mainAxisAlignment: MainAxisAlignment.center,
          // children
          children: <Widget>[
            // a text
            const Text(
              'You have pushed the button this many times:',
            ),
            // a text
            Text('Count using StateProvider: $count.toString()'),

            homeValue.when(
              data: (data) =>
                  Text('Count using AsyncNotifierProvider: $data.toString()'),
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Text('Error: $error'),
            ),
          ],
        ),
      ),
      // floating action button
      floatingActionButton: FloatingActionButton(
        // on pressed
        onPressed: () {
          counter.increment();
          homeValueController._loadData();
        },
        // tooltip
        tooltip: 'Increment',
        // child
        child: const Icon(Icons.add),
      ),
    );
  }
}

@riverpod
class HomeController extends _$HomeController {
  @override
  Future<int> build() async {
    return _loadData();
  }

  Future<int> _loadData() {
    return Future.delayed(const Duration(seconds: 1), () => 3);
  }
}
