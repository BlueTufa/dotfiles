#!/usr/bin/swift
import Foundation
import AppKit

func currentFocusApp() -> String {
    return NSWorkspace.shared.frontmostApplication?.localizedName ?? "<none>"
}

var lastApp = currentFocusApp()
print("\(Date()): Active window started as: \(lastApp)")

let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
    let currentApp = currentFocusApp()
    if currentApp != lastApp {
        print("\(Date()): Focus stolen by -> \(currentApp)")
        lastApp = currentApp
    }
}

RunLoop.current.run()
