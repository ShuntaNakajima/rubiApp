//
//  MainViewController.swift
//  RubiApp
//
//  Created by shunta nakajima on 2019/08/17.
//  Copyright © 2019 Shunta Nakajima. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import ReactorKit

import PinLayout

final class MainViewController: UIViewController, ReactorKit.View {
    var disposeBag = DisposeBag()
    
    init() {
        defer { self.reactor =  MainViewControllerReactor()}
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(reactor: MainViewControllerReactor) {
        
    }
}
