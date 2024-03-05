import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit2cubit/cubits/color/color_cubit.dart';
import 'package:flutter_cubit2cubit/cubits/counter/counter_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ColorCubit>(
          create: (context) => ColorCubit(),
        ),
        BlocProvider<CounterCubit>(
            create: (context) =>
                CounterCubit(colorCubit: context.read<ColorCubit>())),
      ],
      child: MaterialApp(
        title: 'cubit2cubit',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ColorCubit>().state.color,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text(
                'Change Color',
                style: TextStyle(fontSize: 24.0),
              ),
              onPressed: () {
                context.read<ColorCubit>().changeColor();
              },
            ),
            const SizedBox(height: 20.0),
            Text(
              '${context.watch<CounterCubit>().state.counter}',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              child: const Text(
                'Increment Counter',
                style: TextStyle(fontSize: 24.0),
              ),
              onPressed: () {
                context.read<CounterCubit>().changeCounter();
              },
            ),
          ],
        ),
      ),
    );
  }
}
