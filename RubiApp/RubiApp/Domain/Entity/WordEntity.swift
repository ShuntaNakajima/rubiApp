//
//  WordEntity.swift
//  RubiApp
//
//  Created by shunta nakajima on 2019/08/17.
//  Copyright © 2019 Shunta Nakajima. All rights reserved.
//

import SWXMLHash

struct Word: XMLIndexerDeserializable {
    let surface: String
    let furigana: String?
    let roman: String?
    let subWordList: [Word]?
    
    static func deserialize(_ node: XMLIndexer) throws -> Word {
        return try Word(
            surface: node["Surface"].value(),
            furigana: node["Furigana"].value(),
            roman: node["Roman"].value(),
            subWordList: node["SubWordList"]["SubWord"].value()
        )
    }
}
