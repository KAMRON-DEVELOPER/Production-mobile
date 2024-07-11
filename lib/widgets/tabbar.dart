import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 8,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.blueAccent,
        margin: const EdgeInsets.only(left: 8, right: 8),
        padding: const EdgeInsets.all(8.0),
        child: const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 10),
              Text('this is tab1'),
              SizedBox(width: 20),
              Text('this is tab2'),
              SizedBox(width: 20),
              Text('this is tab3'),
              SizedBox(width: 20),
              Text('this is tab4'),
              SizedBox(width: 20),
              Text('this is tab5'),
              SizedBox(width: 20),
              Text('this is tab6'),
              SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
