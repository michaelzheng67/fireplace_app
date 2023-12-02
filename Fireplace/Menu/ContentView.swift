//
//  ContentView.swift
//  Fireplace
//
//  Created by Michael Zheng on 2023-11-23.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {

    @State private var selectedItem: String? = nil
    @State private var hoveredItem: String? = nil
    
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false
    
    @State private var showFireplaceView = false
    @State private var showAlternateView = false
    @State private var musicPlaying = true

    @Environment(DataModel.self) var dataModel
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow

    var body: some View {
        
        // View is split between music side menu and main control menu
        NavigationSplitView {
            List {
                ForEach(["Jazz", "Classic Rock", "Piano", "Opera" ], id: \.self) { item in
                    ListItemView(title: item,
                                 isHovered: hoveredItem == item,
                                 isSelected: selectedItem == item)
                    .hoverEffect(.automatic)
                    .onTapGesture {
                        musicPlaying = true
                        selectedItem = item
                        let state = musicSelection.from(musicChoice: selectedItem)
                        dataModel.playMusic(music: state, currMusicPlaying: musicPlaying)
                    }
                }
            }.toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    VStack (alignment: .leading) {
                        Text("Music Library")
                            .font(.largeTitle)
                    }
                }
            }
            
            // Main menu content
        } detail: {
            
            
//            Text("Fireplace App")
            Toggle("Show Fireplace", isOn: $showFireplaceView)
                .toggleStyle(.button)
                .onChange(of: showFireplaceView) {_, isShowing in
                    if isShowing {
                        openWindow(id: "FireplaceView")
                        dataModel.playFireplaceSounds();
                    } else {
                        dismissWindow(id: "FireplaceView")
                        dataModel.stopFireplaceSounds();
                    }
                }
            
            // only show these elements when music is selected
            if let selectedItemConst = selectedItem {
                Divider()
                Text("Selected Item: \(selectedItemConst)")
                
                
                HStack {
                    
                    // backward button
                    Button(action: {
                        dataModel.backwardMusic()
                        selectedItem = dataModel.currToString()
                        musicPlaying = true
                    }) {
                        Image(systemName: "backward.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40) // Adjust frame size as needed
                            .padding(10) // Adjust padding as needed
                            .foregroundColor(.white)
                    }
                    
                    
                    // play button
                    Button(action: {
                        musicPlaying.toggle()
                        if musicPlaying {
                            dataModel.restartMusic()
                        } else {
                            dataModel.stopMusic()
                        }
                    }) {
                        Image(systemName: musicPlaying ? "pause.fill" : "play.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40) // Adjust frame size as needed
                            .padding(10) // Adjust padding as needed
                            .foregroundColor(.white)
                    }
                    
                    
                    // forward button
                    Button(action: {
                        dataModel.forwardMusic()
                        selectedItem = dataModel.currToString()
                        musicPlaying = true
                    }) {
                        Image(systemName: "forward.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40) // Adjust frame size as needed
                            .padding(10) // Adjust padding as needed
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}


// Struct for each music item in the side list
struct ListItemView: View {
    let title: String
    var isHovered: Bool
    var isSelected: Bool

    var body: some View {
        Text(title)
            .padding()
            .background(isSelected ? Color.gray : (isHovered ? Color.blue : Color.clear))
            .cornerRadius(5)
            .foregroundColor(.white)
    }
}




#Preview(windowStyle: .automatic) {
    ContentView()
}
