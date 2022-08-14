//
//  Photo.swift
//  Navigation
//
//  Created by Vadim on 07.03.2022.
//

import UIKit

var arrayPhotos: [UIImage] = []

func appendArrayPhotos() {
    for i in (1...21).shuffled() {
        arrayPhotos.append(((UIImage(named: "\(i)") ?? UIImage(named: "error"))!))
    }
}
