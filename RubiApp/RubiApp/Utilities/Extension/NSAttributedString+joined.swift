//
//  NSAttributedString+joined.swift
//  RubiApp
//
//  Created by shunta nakajima on 2019/08/18.
//  Copyright © 2019 Shunta Nakajima. All rights reserved.
//

import Foundation

extension Sequence where Iterator.Element == NSAttributedString {
    func joined(attributedSeparator: Iterator.Element) -> Iterator.Element {
        let attributedString = self.enumerated()
            .map { (index, element) -> NSAttributedString in
                if index == 0 {
                    return element
                }
                let mutable = NSMutableAttributedString(attributedString: attributedSeparator)
                mutable.append(element)
                return mutable
            }
            .reduce(NSMutableAttributedString(), { (list, element) -> NSMutableAttributedString in
                list.append(element)
                return list
            })
        return Iterator.Element(attributedString: attributedString)
    }
    
    func joined(separator: String) -> Iterator.Element {
        return joined(attributedSeparator: Iterator.Element(string: separator))
    }
    
    var joined: Iterator.Element {
        return joined(separator: "")
    }
}
