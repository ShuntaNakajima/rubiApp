//
//  NetworkTests.swift
//  RubiApp
//
//  Created by shunta nakajima on 2019/08/17.
//  Copyright © 2019 Shunta Nakajima. All rights reserved.
//

import XCTest
import RxCocoa
import RxSwift

import ReactorKit

@testable import RubiApp

class NetworkTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRequest(){
        print(Request.requestHiraganaXML(param: ["sentence":"これはテストです"] ))
        XCTAssertNotNil(Request.requestHiraganaXML(param: ["sentence":"これはテストです"]))
    }

}
