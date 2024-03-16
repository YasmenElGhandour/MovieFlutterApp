import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';

class loading extends StatelessWidget {
  const loading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 200,
      child: Center(
        child: CircularProgressIndicator(color: Colours.SecondryColor,),
      ),
    );
  }
}