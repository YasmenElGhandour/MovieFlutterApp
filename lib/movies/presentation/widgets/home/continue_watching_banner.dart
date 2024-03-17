import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';

class ContinueWatchingBanner extends StatelessWidget {
  const ContinueWatchingBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
          alignment :AlignmentDirectional.bottomStart,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "assets/popular.png",
                  height: 200.0,
                  width: 350,
                  fit: BoxFit.cover,
                )),
            Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withOpacity(0.3)),
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.all(Radius.circular(15.0) //                 <--- border radius here
                ),

              ),
              width: 200,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/Icon.png",
                  ),
                  SizedBox(
                    width:8,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'continue watching',
                        style: TextStyle(fontFamily: 'AABB', fontSize: 16, color: Colours.GrayColor),
                      ),
                      Text(
                        'Ready Player One',
                        style: TextStyle(fontFamily: 'AABB', fontSize: 16),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}
