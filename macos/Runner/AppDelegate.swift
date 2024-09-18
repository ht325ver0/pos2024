import Cocoa
import FlutterMacOS
import FirebaseCore  // 追加

@main
class AppDelegate: FlutterAppDelegate {
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }

  override func applicationDidFinishLaunching(_ notification: Notification) {
    FirebaseApp.configure()  // Firebaseの初期化をここで行います
  }
}
