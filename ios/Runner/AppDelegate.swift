import UIKit
import Flutter
import flutter_downloader

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    FlutterDownloaderPlugin.setPluginRegistrantCallback(registerPlugins)
    disableICloudBackup()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func disableICloudBackup() {
        do {
          try setExcludeFromICloudBackup(filePath: NSHomeDirectory() + "/Library")
          try setExcludeFromICloudBackup(filePath: NSHomeDirectory() + "/Documents")
        } catch {
          print("Couldn't disable iCloud Backup")
        }
      }

    private func setExcludeFromICloudBackup(filePath: String) throws {
        let url = NSURL.fileURL(withPath: filePath) as NSURL
        try url.setResourceValue(true, forKey: URLResourceKey.isExcludedFromBackupKey)
      }
}

private func registerPlugins(registry: FlutterPluginRegistry) {
    if (!registry.hasPlugin("FlutterDownloaderPlugin")) {
       FlutterDownloaderPlugin.register(with: registry.registrar(forPlugin: "FlutterDownloaderPlugin")!)
    }
}
