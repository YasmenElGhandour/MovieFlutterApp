import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  const NoData(this.message, {
    super.key,
  });
  final String message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        child: Text(message, style: TextStyle(fontFamily: 'AABB', fontSize: 18),)
    );
  }
}