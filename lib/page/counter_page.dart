import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_testing/provider/counter_provider.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    final int newCounter = context.watch<CounterProvider>().counter;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            TextCounter(),
          ],
        ),
      ),
      floatingActionButton: ButtonBar(
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<CounterProvider>().decrement();
            },
            heroTag: 'Decrement',
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterProvider>().increment();
            },
            heroTag: 'Increment',
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

class TextCounter extends StatelessWidget {
  const TextCounter({super.key});

  @override
  Widget build(BuildContext context) {
    final newCounter = context.watch<CounterProvider>().counter;
    return Text(
      '$newCounter',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
