import 'package:flutter/material.dart';

class Loding extends StatelessWidget {
  const Loding({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
