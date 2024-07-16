import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/counter/counter_bloc.dart';
import '../../widgets/drawer_widget.dart';

class EntertainmentScreen extends StatelessWidget {
  const EntertainmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return buildDrawerWidget(
      context: context,
      appBarTitle: 'AI screen',
      content: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('SOME TEXT HERE'),
            BlocBuilder<CounterBloc, int>(
              builder: (context, counter) => Text(
                '$counter',
                style: const TextStyle(fontSize: 32),
              ),
            ),
            ElevatedButton(
              onPressed: () =>
                  BlocProvider.of<CounterBloc>(context).add(CounterIncrement()),
              child: const Icon(Icons.add),
            ),
            ElevatedButton(
              onPressed: () =>
                  BlocProvider.of<CounterBloc>(context).add(CounterDecrement()),
              child: const Icon(Icons.exposure_minus_1),
            ),
          ],
        ),
      ),
    );
  }
}
