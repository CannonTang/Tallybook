//
//  CustomMoneyManagerApp.swift
//  CustomMoneyManager
//
//  Created by windbylocus on 2026/5/18.
//

import SwiftUI

@main
struct CustomMoneyManagerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .background(
                    WindowAccessor { window in
                        WindowConfigurator.configure(window)
                    }
                )
        }
        .defaultSize(width: 1180, height: 760)
        .windowResizability(.contentMinSize)
        .commands {
            SidebarCommands()
        }
    }
}
