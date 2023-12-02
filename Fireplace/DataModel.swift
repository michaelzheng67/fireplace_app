//
//  DataModel.swift
//  Fireplace
//
//  Created by Michael Zheng on 2023-11-28.
//

import Foundation
import AVKit
import RealityKit
import SwiftUI

@Observable
class DataModel {
    var currMusic: musicSelection = .none
    
    // mp3 sounds
    var fireplaceSounds = try! AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "fireplace", withExtension: "mp3")!)
    
    var jazzSounds = try! AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "jazz", withExtension: "mp3")!)
    var classicRockSounds = try! AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "classicRock", withExtension: "mp3")!)
    var pianoSounds = try! AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "piano", withExtension: "mp3")!)
    var operaSounds = try! AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "opera", withExtension: "mp3")!)

    func currToString() -> String {
        switch currMusic {
        case .jazz:
            return "Jazz"
        case .classicRock:
            return "Classic Rock"
        case .piano:
            return "Piano"
        case .opera:
            return "Opera"
        default:
            return ""
        }
    }

    func playFireplaceSounds() {
        fireplaceSounds.numberOfLoops = -1 // Loop indefinitely
        fireplaceSounds.play()
    }
    
    func stopFireplaceSounds() {
        fireplaceSounds.stop()
    }
    
    // for when the user selects a song on the side menu
    func playMusic(music: musicSelection, currMusicPlaying: Bool) {
        // need to pause current music before playing new one
        if currMusicPlaying {
            
            switch currMusic {
            case .jazz:
                jazzSounds.stop()
            case .classicRock:
                classicRockSounds.stop()
            case .piano:
                pianoSounds.stop()
            case .opera:
                operaSounds.stop()
            case .none:
                break
            }
        }
        
        // play the music just selected
        currMusic = music
        switch music {
        case .jazz:
            jazzSounds.numberOfLoops = -1
            jazzSounds.play()
        case .classicRock:
            classicRockSounds.numberOfLoops = -1
            classicRockSounds.play()
        case .piano:
            pianoSounds.numberOfLoops = -1
            pianoSounds.play()
        case .opera:
            operaSounds.numberOfLoops = -1
            operaSounds.play()
        case .none:
            break
        }
    }
    
    // restarts again whatever music is currently defined in currMusic
    func restartMusic() {
        switch currMusic {
        case .jazz:
            jazzSounds.play()
        case .classicRock:
            classicRockSounds.play()
        case .piano:
            pianoSounds.play()
        case .opera:
            operaSounds.play()
        case .none:
            break
        }
    }
    
    // stops whatever music is currently defined in currMusic
    func stopMusic() {
        switch currMusic {
        case .jazz:
            jazzSounds.stop()
        case .classicRock:
            classicRockSounds.stop()
        case .piano:
            pianoSounds.stop()
        case .opera:
            operaSounds.stop()
        case .none:
            break
        }
    }
    
    // plays the song before it
    func backwardMusic() {
        switch currMusic {
        case .classicRock:
            classicRockSounds.stop()
            jazzSounds.play()
            currMusic = .jazz
        case .piano:
            pianoSounds.stop()
            classicRockSounds.play()
            currMusic = .classicRock
        case .opera:
            operaSounds.stop()
            pianoSounds.play()
            currMusic = .piano
        default:
            break
        }
    }
    
    // plays the song after it
    func forwardMusic() {
        switch currMusic {
        case .jazz:
            jazzSounds.stop()
            classicRockSounds.play()
            currMusic = .classicRock
        case .classicRock:
            classicRockSounds.stop()
            pianoSounds.play()
            currMusic = .piano
        case .piano:
            pianoSounds.stop()
            operaSounds.play()
            currMusic = .opera
        default:
            break
        }
    }
    
    init() {
        Task { @MainActor in
            // Initialize the audio player
//            if isPlaying {
//                do {
//                    fireplaceSounds.play()
//                    fireplaceSounds.numberOfLoops = -1 // Loop indefinitely
//                }
//            }
        }
    }
}


enum musicSelection {
    
    static func from(musicChoice: String?) -> Self {
        if musicChoice == "Jazz" {
            return .jazz
        } else if musicChoice == "Classic Rock" {
            return .classicRock
        } else if musicChoice == "Piano" {
            return .piano
        } else if musicChoice == "Opera" {
            return .opera
        }
        
        
        return .none
    }
    
    case none
    case jazz
    case classicRock
    case piano
    case opera
}
