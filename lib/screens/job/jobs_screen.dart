import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/cubit/counter_cubit/counter_cubit.dart';
import 'package:mobile/widgets/drawer_widget.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return buildDrawerWidget(
      context: context,
      appBarTitle: 'Jobs screen',
      content: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<CounterCubit, int>(
              builder: (context, counter) =>
                  Text('$counter', style: const TextStyle(fontSize: 32)),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () =>
                    BlocProvider.of<CounterCubit>(context).increment(),
                child: const Icon(Icons.add)),
          ],
        ),
      ),
    );
  }
}
