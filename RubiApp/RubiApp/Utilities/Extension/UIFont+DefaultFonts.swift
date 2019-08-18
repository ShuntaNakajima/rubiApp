//
//  UIFont+DefaultFonts.swift
//  RubiApp
//
//  Created by shunta nakajima on 2019/08/18.
//  Copyright © 2019 Shunta Nakajima. All rights reserved.
//

import UIKit

public enum DefaultFont: String {
    case hiraginow3 = "HiraMinProN-W3"
}

extension UIFont {
    public static func defaultFont(_ fontName: DefaultFont, size: CGFloat) -> UIFont {
        return UIFont(name: fontName.rawValue, size: size)!
    }
}

