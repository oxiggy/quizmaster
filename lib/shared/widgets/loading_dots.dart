import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingDots extends StatelessWidget {
  const LoadingDots({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitChasingDots(
      color: Colors.teal[200],
      size: 200.0,
    );
  }
}