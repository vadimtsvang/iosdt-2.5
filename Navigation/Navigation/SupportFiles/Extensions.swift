//
//  Extensions.swift
//  Navigation
//
//  Created by Vadim on 07.03.2022.
//

import UIKit

public extension UIColor {

    convenience init?(hex: String) {

        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        let length = hexSanitized.count

        var rgb: UInt64 = 0

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            return nil
        }

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255
            b = CGFloat(rgb & 0x0000FF) / 255
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255
            a = CGFloat(rgb & 0x000000FF) / 255

        } else {
            return nil
        }
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}


public extension UIImage {
    func image(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}


public extension UIView {
    func addSubviews(_ subviews: UIView...) {
        for i in subviews {
            i.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(i)
        }
    }
}

extension UITextField {

    func indent(size: CGFloat){
        self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height))
        self.leftViewMode = .always
    }
}

extension StringProtocol {
    var firstUppercased: String {
        guard let first = first else { return ""}
        return String(first).uppercased() + dropFirst()
    }
}
