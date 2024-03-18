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
            
            switch call.method {
                
            case "getDataFromNativeCode":
            guard let arguments = call.arguments as? [String: String] else {return}
             let apiKey = arguments["apiKey"]!
              self.getDiscoverMovies(result: result, apiKey: apiKey)

            case "getDetails":
                guard let arguments = call.arguments as? [String: String] else {return}
                let apiKey = arguments["apiKey"]!
                let movieIdString = arguments["movieId"]!
                let movieId = Int(movieIdString)!
                
                self.getDetails(result:result,apiKey:apiKey,movieId:movieId)

            default:
                result(FlutterMethodNotImplemented)
            }
            
        })
      
      GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    


    func getDiscoverMovies(result: @escaping FlutterResult , apiKey: String){
      let movieManager = MovieManager()
      movieManager.fetchDiscoverMovies(result:result,apiKey: apiKey)
    }
    


       func getDetails(result : @escaping FlutterResult,apiKey:String,movieId:Int){
        let movieManager = MovieManager()
           movieManager.fetchDetailsMovie(result:result,apiKey:apiKey,movieId:movieId)
        }
    
}
