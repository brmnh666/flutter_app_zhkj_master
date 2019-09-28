import UIKit
import Flutter
#import "FlutterAlipayPlugin.h"

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

     // ios 8.x or older
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{

    return [FlutterAlipayPlugin handleOpenURL:url];
}
// ios 9.0+
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
     return [FlutterAlipayPlugin handleOpenURL:url];
}


}
