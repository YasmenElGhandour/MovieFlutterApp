import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 200,
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 40,),
            Icon(Icons.signal_wifi_connected_no_internet_4_outlined, color: Colours.GrayColor,size: 60,),
            SizedBox(height: 20,),
            Text('No Internet Connection',
              style: TextStyle(fontFamily: 'AABB', fontSize: 16,color: Colours.GrayColor ),

            )
          ],
        ),
      ),
    );
  }
}