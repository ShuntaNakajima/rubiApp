//
//  RubyViewController.swift
//  RubiApp
//
//  Created by shunta nakajima on 2019/08/18.
//  Copyright © 2019 Shunta Nakajima. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import ReactorKit

import PinLayout

final class RubyViewController: UIViewController ,ReactorKit.View{
    var disposeBag = DisposeBag()
    
    private let rubyScrollView = UIScrollView()
    private var rubyView = RubyView()
    private let backButton = UIButton()
    
    init() {
        defer { self.reactor =  RubyViewControllerReactor()}
        super.init(nibName: nil, bundle: nil)
        
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView(){
        view.backgroundColor = .white
        self.title = "ルビ振り結果"
        
        backButton.setTitleColor(.white, for: .normal)
        backButton.backgroundColor = .black
        backButton.setTitle("もう一度ルビを振る", for: .normal)
        
        view.addSubview(rubyScrollView)
        view.addSubview(backButton)
    }
    
    
    public func fetchRuby(sentence:String){
        guard let reactor = self.reactor else {
            return
        }
        reactor.action.onNext(.getWords(sentence))
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        rubyScrollView.pin.width(80%).bottom(100).top(view.safeAreaInsets.top).hCenter()
        backButton.pin.width(60%).height(50).bottom(50).marginBottom(10).hCenter()
        backButton.layer.cornerRadius = backButton.frame.height / 2
    }
    
    func bind(reactor: RubyViewControllerReactor) {
        reactor.state.map{ $0.words }
            .observeOn(MainScheduler.instance)
            .bind {[weak self] words in
                guard let self = self else { return }
                guard let words = words else { return }
                self.rubyView.setWords(words: words)
                self.rubyScrollView.addSubview(self.rubyView)
                self.rubyView.pin.top().width(100%)
                self.rubyView.pin.height(self.rubyView.charHight + 20)
                self.rubyScrollView.contentSize.height = self.rubyView.frame.height
            }.disposed(by: disposeBag)
        
        backButton.rx.tap.asDriver()
            .drive(onNext: { _ in
                self.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
    }
}
