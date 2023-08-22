//
//  DalleVisionApp.swift
//  DalleVision
//
//  Created by Miffy Chen on 2023-08-22.
//

import SwiftUI

@main
struct DalleVisionApp: App {
    
    @State private var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(viewModel)
        }.windowStyle(.plain)

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
