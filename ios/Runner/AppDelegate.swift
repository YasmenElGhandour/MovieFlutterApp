import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let batteryChannel = FlutterMethodChannel(name: "com.example.movie_app_task/native",
                                                  binaryMessenger: controller.binaryMessenger)
        batteryChannel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
         
            guard call.method == "getDataFromNativeCode" else {
                result(FlutterMethodNotImplemented)
                return
            }
             self.getData(result:result)
            
        })
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
     func getData(result : FlutterResult){
        let message = "message from swift"
        if message.isEmpty{
            result(FlutterError(code:"UnAvailable" ,
                                message:"message from swift is empty" , details:nil

                               ))
        }else{
            result(message)
        }
        
    }
}
