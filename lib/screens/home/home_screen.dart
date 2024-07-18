import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/network_provider.dart';
import '../../widgets/drawer_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final CheckConnectivityProvider? connectionStatus =
      CheckConnectivityProvider();

  @override
  Widget build(BuildContext context) {
    return buildDrawerWidget(
      context: context,
      appBarTitle: 'Home screen',
      content: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<CheckConnectivityProvider>(
              builder: (context, connectivityProvider, child) {
                return Text(
                  connectivityProvider.status.toString(),
                  style: TextStyle(
                    fontSize: 36,
                    color: connectivityProvider.status == 'Offline'
                        ? Colors.red
                        : Colors.green,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
