//
//  MediaViewModel.swift
//  Navigation
//
//  Created by Vadim on 31.05.2022.
//

import Foundation
import UIKit

final class AudioViewModel {

    var audioLibrary: [(title: String, artist: String, url: URL?, image: String?)] = []

    init() {
        for i in nameAudioArray.enumerated() {
            let value = i.element
            audioLibrary.append((title: value.title,
                                 artist: value.artist,
                                 url: URL(fileURLWithPath: Bundle.main.path(forResource: value.url, ofType: "mp3")!),
                                 image : value.image))
        }
    }

    private var nameAudioArray: [Audio] = [
        Audio(title: "1", artist: "The Roots", url: "Music1", image: ""),
        Audio(title: "2", artist: "The Roots", url: "Music2", image: ""),
        Audio(title: "3", artist: "The Roots", url: "Music3", image: ""),
        Audio(title: "4", artist: "The Roots", url: "Music4", image: ""),
        Audio(title: "5", artist: "The Roots", url: "Music5", image: "")
    ]
}

