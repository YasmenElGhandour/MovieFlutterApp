
import 'package:flutter/material.dart';
import 'package:movie_app_task/core/theme/colors.dart';
import 'dart:io';
import 'movies/presentation/screens/home_screen.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colours.PrimaryColor,
            useMaterial3: true
      ),
      home: const HomeScreen(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   String _responseFromNativeCode = 'no data';
//   static const platform=MethodChannel("com.example.movie_app_task/native");
//
//   // Future<void> getData() async{
//   //   String message;
//   //   try{
//   //     message = await platform.invokeMethod("getDataFromNativeCode");
//   //   }on PlatformException catch(e){
//   //     message = 'failed to get message ${e.message}';
//   //   }
//   //   setState(() {
//   //     _responseFromNativeCode = message;
//   //   });
//   //
//   // }
//
//   // Future<void> getDetails() async{
//   //   String message;
//   //   try{
//   //      message = await platform.invokeMethod("getDetails" , {"movieId":848538});
//   //   }on PlatformException catch(e){
//   //     message = 'failed to get message ${e.message}';
//   //   }
//   //
//   //   setState(() {
//   //     _responseFromNativeCode = message;
//   //   });
//   //
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//              Text(_responseFromNativeCode,maxLines: 4, ),
//             ElevatedButton(onPressed: getDetails, child: Text(
//               'get data'
//             ))
//           ],
//         ),
//       ),
// // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}