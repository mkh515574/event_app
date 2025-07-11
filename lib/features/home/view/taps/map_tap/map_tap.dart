import 'package:flutter/material.dart';

class MapTap extends StatelessWidget {
  const MapTap({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text("Map Screen",style: Theme.of(context).textTheme.titleMedium,))
        ],
      ),
    );
  }
}
