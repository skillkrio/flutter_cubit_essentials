import 'package:cubit_and_bloc/cubits/counter/counter_cubit.dart';
import 'package:cubit_and_bloc/otherpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const WidgetApp());
}

class WidgetApp extends StatelessWidget {
  const WidgetApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CounterCubit, CounterState>(
        listener: (context, state) {
          if (state.counter == 3) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Text("counter is ${state.counter}"),
              ),
            );
          }
          if (state.counter == -1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OtherPage(),
              ),
            );
          }
        },
        builder: (context, state) => BlocBuilder<CounterCubit, CounterState>(
          buildWhen: (previous, current) {
            return false;
          },
          builder: (context, state) => Center(
            child: Text(
              "${state.counter}",
              style: const TextStyle(fontSize: 50),
            ),
          ),
        ),
      ),
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          onPressed: () {
            BlocProvider.of<CounterCubit>(context).increment();
          },
          heroTag: "increment",
          child: const Icon(Icons.add),
        ),
        const SizedBox(
          width: 10,
        ),
        FloatingActionButton(
          onPressed: () {
            BlocProvider.of<CounterCubit>(context).decrement();
          },
          heroTag: "decrement",
          child: const Icon(Icons.remove),
        ),
      ]),
    );
  }
}
