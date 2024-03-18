import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    // let apiKey="c4c77dec8838783e8651d15e92df4606"
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "com.example.movie_app_task/native",
                                                  binaryMessenger: controller.binaryMessenger)
        channel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            
            guard call.method == "getDataFromNativeCode" else {
                result(FlutterMethodNotImplemented)
                return
            }
            guard let arguments = call.arguments as? [String: Any],
                  let apiKey = arguments["apiKey"] as? String
            else {
                // Handle missing or invalid arguments
                return
            }
            
            
            Task {
                 if let error = await self.getDiscoverMovies(apiKey: apiKey) {
                   result(error) // Pass through the FlutterError
                 } else {
                   result("success") // Or any success message you prefer
                 }
               }
            
            
            //.........details ...........
            guard call.method == "getDetails" else {
                result(FlutterMethodNotImplemented)
                return
            }
            guard let arguments = call.arguments as? [String: Any],
                  let apiKey = arguments["apiKey"] as? String,
                  let movieIdString = arguments["movieId"] as? String,
                  let movieId = Int(movieIdString)
            else {
                // Handle missing or invalid arguments gracefully
                // Provide appropriate error messaging or fallback behavior
                return
            }
            
            self.getDetails(result:result,apiKey:apiKey,movieId:movieId)
            
        })
      
      GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    

    func getDiscoverMovies( apiKey: String) async -> String? {
      let movieManager = MovieManager()
        let movies =  await movieManager.fetchDiscoverMovies(apiKey: apiKey)
        let json = String(describing: movies)
        print("okkkkk")
        print(json)
        
        return json
    }
    


       func getDetails(result : FlutterResult,apiKey:String,movieId:Int){
             let movieManager = MovieManager()
           movieManager.fetchDetailsMovie(result:result,apiKey:apiKey,movieId:movieId)
           result("result")


        }
    
}
