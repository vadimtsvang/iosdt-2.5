//
//  VideoViewModel.swift
//  Navigation
//
//  Created by Vadim on 03.06.2022.
//

import Foundation
import UIKit

final class VideoViewModel {

    var videoArray: [(title: String, url: String)] = []

    init() {
        appendVideo()
    }

    func appendVideo() {
        videoArray.removeAll()
        videoArray.append((title: "Add YouTube Video in App Swift 5",
                           url: "bsM1qdGAVbU"))
        videoArray.append((title: "Как играть на бас-гитаре (для новичков)",
                           url: "EblaED750dY"))
        videoArray.append((title: "8 String VS Djent Stick",
                           url: "g_cpVyZ_ZSY"))
        videoArray.append((title: "Multithreading в swift с нуля: урок 1 - Thread & Pthread",
                           url: "JtDf-S1uLLs"))
        videoArray.append((title: "8-летняя Джулия исполняет хардкор",
                           url: "KGJTg0Rhor0"))
    }
}
