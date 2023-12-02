//
//  FireplaceApp.swift
//  Fireplace
//
//  Created by Michael Zheng on 2023-11-23.
//

import SwiftUI

@main
struct FireplaceApp: App {
    @State private var datamodel = DataModel()
    
    var body: some Scene {
        WindowGroup("Fireplace", id: "Home") {
            ContentView()
                .environment(datamodel)
        }.windowStyle(.automatic)
        
        WindowGroup(id: "FireplaceView") {
            FireplaceView()
        }.windowStyle(.volumetric)

        
        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.full), in: .full)
    }
}
