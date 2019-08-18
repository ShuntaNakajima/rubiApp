//
//  Request.swift
//  RubiApp
//
//  Created by shunta nakajima on 2019/08/17.
//  Copyright © 2019 Shunta Nakajima. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire
import RxCocoa
import RxSwift
import SWXMLHash

class Request {
    
    enum APIError: Error {
        case network
    }
    
    static var endPointURLStr:String {
        return "https://jlp.yahooapis.jp/FuriganaService/V1/furigana"
    }
    
    public static func requestHiraganaXML(param: [String: Any]?) -> Single<[Word]?>{
        let endPoint = endPointURLStr
        var param = param
        param?["appid"] = APIkey.key
        return RxAlamofire.requestData(.get,
                                       endPoint,
                                       parameters: param,
                                       encoding: URLEncoding.default)
            .asSingle()
            .map { response, data in
                let xml = SWXMLHash.parse(data)
                guard let words:[Word] = try xml["ResultSet"]["Result"]["WordList"]["Word"].value() else {
                    throw APIError.network
                }
                return words
            }
    }
}
