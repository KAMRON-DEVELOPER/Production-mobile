import 'package:flutter/material.dart';
import '../../widgets/drawer_widget.dart';

class AiScreen extends StatefulWidget {
  const AiScreen({super.key});

  @override
  State<AiScreen> createState() => _AiScreenState();
}

class _AiScreenState extends State<AiScreen> {
  @override
  Widget build(BuildContext context) {
    return buildDrawerWidget(
      context: context,
      appBarTitle: 'AI screen',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('AI SCREEN BODY'),
          Expanded(
            child: ListView.builder(
              itemCount: 50,
              itemBuilder: (context, index) => ListTile(
                title: Text('Item $index'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
