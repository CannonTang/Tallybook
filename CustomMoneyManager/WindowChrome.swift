//
//  WindowChrome.swift
//  CustomMoneyManager
//
//  Created by windbylocus on 2026/5/18.
//

import AppKit
import SwiftUI

struct WindowAccessor: NSViewRepresentable {
    let configure: (NSWindow) -> Void

    func makeNSView(context: Context) -> NSView {
        let view = NSView(frame: .zero)
        DispatchQueue.main.async {
            if let window = view.window {
                configure(window)
            }
        }
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {
        DispatchQueue.main.async {
            if let window = nsView.window {
                configure(window)
            }
        }
    }
}

enum WindowConfigurator {
    private static let configuredIdentifier = NSUserInterfaceItemIdentifier("CustomMoneyManager.ConfiguredWindow")

    static func configure(_ window: NSWindow) {
        guard window.identifier != configuredIdentifier else { return }
        window.identifier = configuredIdentifier

        window.styleMask.formUnion([.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView])
        window.titleVisibility = .hidden
        window.titlebarAppearsTransparent = true
        window.isMovableByWindowBackground = true
        window.isReleasedWhenClosed = false
        window.tabbingMode = .disallowed
        window.backgroundColor = .windowBackgroundColor
        window.minSize = NSSize(width: 920, height: 640)
        window.contentMinSize = NSSize(width: 920, height: 640)
        window.center()
        window.setFrameAutosaveName("MainWindow")

        window.standardWindowButton(.closeButton)?.isHidden = false
        window.standardWindowButton(.miniaturizeButton)?.isHidden = false
        window.standardWindowButton(.zoomButton)?.isHidden = false
    }
}
