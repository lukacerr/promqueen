import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        child: CircularProgressIndicator(
          strokeWidth: 5,
          color: Colors.blueGrey,
        ),
        height: 100,
        width: 100,
      )
    );
  }
}
