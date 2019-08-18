//
//  RubyView.swift
//  RubiApp
//
//  Created by shunta nakajima on 2019/08/18.
//  Copyright © 2019 Shunta Nakajima. All rights reserved.
//

import Foundation
import CoreText
import UIKit

final class RubyView: UIView {
    private var words = [Word]()
    
    lazy var textAttributes: [NSAttributedString.Key: Any] = {
        let style = NSMutableParagraphStyle()
        style.minimumLineHeight = 20
        style.maximumLineHeight = 20
        return [.font: UIFont.defaultFont(.hiraginow3, size: 16),
                .paragraphStyle: style]
    }()
    
    var attributedText: NSAttributedString {
        //Word配列をNSAttributedStringにして返す
        return words.map{ word -> NSAttributedString in
            if let wordList = word.subWordList{
                return wordList.map{ subword -> NSAttributedString in
                    if let subfurigana = subword.furigana{
                        if subword.surface == subfurigana{
                            return NSMutableAttributedString(string: subword.surface, attributes: textAttributes)
                        } else {
                            return createRuby(string: subword.surface, ruby: subfurigana)
                        }
                    }else{
                        return NSMutableAttributedString(string: subword.surface, attributes: textAttributes)
                    }
                    }.joined
            }else{
                if let furigana = word.furigana{
                    if word.surface == furigana{
                        return NSMutableAttributedString(string: word.surface, attributes: textAttributes)
                    } else {
                        return createRuby(string: word.surface, ruby: furigana)
                    }
                }else{
                    return NSMutableAttributedString(string: word.surface, attributes: textAttributes)
                }
            }
            }.joined
    }
    
    var charHight: CGFloat {
        return attributedText.height(withConstrainedWidth: self.frame.width)
    }
    
    func setWords(words:[Word]){
        self.words = words
    }
    
    private func createRuby(string: String, ruby: String) -> NSAttributedString {
        var unmanage = Unmanaged.passRetained(ruby as CFString)
        defer { unmanage.release() }
        var text: [Unmanaged<CFString>?] = [unmanage, .none, .none, .none]
        let annotation = CTRubyAnnotationCreate(.auto, .auto, 0.5, &text)
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: [kCTRubyAnnotationAttributeName as NSAttributedString.Key: annotation])
        attributedString.addAttributes(textAttributes, range: NSRange(location: 0, length: string.count))
        return attributedString
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.setFillColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        context.addRect(rect)
        context.fillPath()
        
        context.textMatrix = .identity
        context.scaleBy(x: 1.0, y: -1.0)
        context.translateBy(x: 0, y: -rect.height - 10)
        
        let framesetter = CTFramesetterCreateWithAttributedString(attributedText)
        let path = CGPath(rect: CGRect(x: 0.0, y: 0.0, width: rect.width, height: rect.height), transform: nil)
        let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, nil)
        CTFrameDraw(frame, context)
    }
}
