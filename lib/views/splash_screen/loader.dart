import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loader extends StatefulWidget {
  const Loader({super.key});

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      body: Center(
      child: LoadingAnimationWidget.twistingDots(
      leftDotColor: const Color(0xFF1A1A3F),
    rightDotColor: const Color(0xFFEA3799),
    size: 200,
    ),
    ),
    );
  }
}
