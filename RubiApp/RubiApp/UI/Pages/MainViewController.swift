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
    
    private let rubyScrollView = UIScrollView()
    private var rubyView = RubyView()
    
    init() {
        defer { self.reactor =  MainViewControllerReactor()}
        super.init(nibName: nil, bundle: nil)
        
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView(){
        view.backgroundColor = .white
        
        rubyScrollView.addSubview(rubyView)
        view.addSubview(rubyScrollView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        rubyScrollView.pin.width(80%).height(30%).top(view.safeAreaInsets.top).hCenter()
    }
    
    func bind(reactor: MainViewControllerReactor) {
        reactor.action.onNext(.getWords("私は当時やはりこういう記憶ように対して事の時に申しなけれある。"))
        reactor.state.map{ $0.words }
            .observeOn(MainScheduler.instance)
            .bind {[weak self] words in
                guard let self = self else { return }
                guard let words = words else { return }
                self.rubyView.removeFromSuperview()
                self.rubyView = RubyView()
                self.rubyView.setWords(words: words)
                self.rubyScrollView.addSubview(self.rubyView)
                self.rubyView.pin.top().width(100%)
                self.rubyView.pin.height(self.rubyView.charHight + 20)
                self.rubyScrollView.contentSize.height = self.rubyView.frame.height
            }.disposed(by: disposeBag)
    }
}
