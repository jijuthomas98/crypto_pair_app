import 'package:flutter/material.dart';

void main() {
  runApp(const AppRunner());
}

class AppRunner extends StatelessWidget {
  const AppRunner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Crypto pair app',
    );
  }
}
