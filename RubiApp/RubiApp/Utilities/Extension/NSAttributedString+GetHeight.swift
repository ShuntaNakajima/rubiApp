//
//  NSAttributedString+GetHeight.swift
//  RubiApp
//
//  Created by shunta nakajima on 2019/08/18.
//  Copyright © 2019 Shunta Nakajima. All rights reserved.
//

import Foundation
import UIKit

extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let rect = self.boundingRect(with: CGSize.init(width: width, height: CGFloat.greatestFiniteMagnitude), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        return ceil(rect.size.height)
    }
}
