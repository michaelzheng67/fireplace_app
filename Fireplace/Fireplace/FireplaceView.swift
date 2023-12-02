//
//  FireplaceView.swift
//  Fireplace
//
//  Created by Michael Zheng on 2023-11-25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct FireplaceView: View {
    
    var body : some View {
        Model3D(named: "Main/Immersive", bundle: realityKitContentBundle)
            
    }
}
