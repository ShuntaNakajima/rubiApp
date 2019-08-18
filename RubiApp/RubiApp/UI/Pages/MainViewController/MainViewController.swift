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
    
    private let inputTextView = UITextView()
    private let doRubyButton = UIButton()
    private var keyboardHeight:CGFloat = 0.0
    
    init() {
        defer { self.reactor =  MainViewControllerReactor()}
        super.init(nibName: nil, bundle: nil)
        
        setUpView()
        setUpKeyBoardNotification()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        inputTextView.becomeFirstResponder()
    }
    
    private func setUpView(){
        view.backgroundColor = .white
        inputTextView.layer.borderWidth = 1.0
        inputTextView.layer.borderColor = UIColor.black.cgColor
        inputTextView.layer.cornerRadius = 3.0
        
        
        doRubyButton.setTitleColor(.white, for: .normal)
        doRubyButton.backgroundColor = .black
        doRubyButton.setTitle("ルビを振る", for: .normal)
        title = "ルビを振りたい文章を入力"
        
        view.addSubview(inputTextView)
        view.addSubview(doRubyButton)
    }
    
    private func setUpKeyBoardNotification(){
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let rect = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return }
        keyboardHeight = rect.size.height
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        doRubyButton.pin.width(60%).height(50).bottom(view.safeAreaInsets.bottom).marginBottom(keyboardHeight + 10).hCenter()
        inputTextView.pin.width(80%).bottom(to: doRubyButton.edge.top).marginBottom(5).top(view.safeAreaInsets.top + 10).hCenter()
        doRubyButton.layer.cornerRadius = doRubyButton.frame.height / 2
    }
    
    func bind(reactor: MainViewControllerReactor) {
        doRubyButton.rx.tap.asDriver()
            .drive(onNext: { _ in
                if !self.inputTextView.text.isEmpty{
                    let rubyVC = RubyViewController()
                    self.navigationController?.pushViewController(rubyVC, animated: true)
                    rubyVC.fetchRuby(sentence: self.inputTextView.text)
                }else{
                    let alert = UIAlertController(title: "エラー", message: "ルビを振りたいを入力してください", preferredStyle: .alert)
                    let okayButton = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                    alert.addAction(okayButton)
                    self.present(alert, animated: true, completion: nil)
                }
            }).disposed(by: disposeBag)
    }
}
