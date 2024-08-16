# DebugView
App debugging log on iPhone/iPad

### Why

As we all know, when testing apps on iPhone/iPad, checking the logs can be a real pain. This is mainly due to the extremely bad connection between iPhone/iPad and xcode.

This package just makes it as easy as possible to view the logs.

### How to use

**Coding**

- Import this package to your project

- Initial

  ```
  import SwiftUI
  import DebugView

  @main
  struct yourApp: App {
      var body: some Scene {
          WindowGroup {
            ZStack {
              ContentView()
              DebugView()
            }
          }
      }
  }
  ```

- Place it where you need

  ```
  import DebugView
  struct ContentView: View {
    // ...
    DebugLogger.shared.log("logs")
    // ...
  }
  ```

**Device: iPhone/iPad**

- Click `bug` on the screen, and you will see all print logs.

https://github.com/user-attachments/assets/c5046d9f-50ee-4455-99bf-df3767c34a8a

### LICENSE

MIT, 2024-Present Bin Hua
