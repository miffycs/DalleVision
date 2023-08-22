//
//  DalleVisionApp.swift
//  DalleVision
//
//  Created by Miffy Chen on 2023-08-22.
//

import SwiftUI

@main
struct DalleVisionApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
