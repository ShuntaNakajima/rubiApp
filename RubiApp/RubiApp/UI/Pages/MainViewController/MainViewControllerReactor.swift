//
//  MainViewControllerReactor.swift
//  RubiApp
//
//  Created by shunta nakajima on 2019/08/17.
//  Copyright © 2019 Shunta Nakajima. All rights reserved.
//

import Foundation

import RxCocoa
import RxSwift

import ReactorKit

final class MainViewControllerReactor: Reactor {
    enum Action {
        case getWords(String)
    }
    
    enum Mutation {
        case setKanaWords([Word])
    }
    
    struct State {
        var kanaStr: String?
        var words: [Word]?
    }
    
    var initialState = State()
    
    func mutate(action: MainViewControllerReactor.Action) -> Observable<MainViewControllerReactor.Mutation> {
        switch action {
        case let .getWords(sentence):
            return Request.requestHiraganaXML(param: ["sentence":sentence]).map {
                if let words = $0 {
                    return Mutation.setKanaWords(words)
                }
                return Mutation.setKanaWords([])
                }
                .asObservable()
        }
    }
    
    func reduce(state: MainViewControllerReactor.State, mutation: MainViewControllerReactor.Mutation) -> MainViewControllerReactor.State {
        var state = state
        switch mutation {
        case let .setKanaWords(words):
            state.words = words
        }
        return state
    }
}
