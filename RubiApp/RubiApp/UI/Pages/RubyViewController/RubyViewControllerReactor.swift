//
//  RubyViewControllerReactor.swift
//  RubiApp
//
//  Created by shunta nakajima on 2019/08/18.
//  Copyright © 2019 Shunta Nakajima. All rights reserved.
//

import Foundation

import RxCocoa
import RxSwift

import ReactorKit

final class RubyViewControllerReactor: Reactor {
    enum Action {
        case getWords(String)
    }
    
    enum Mutation {
        case setKanaWords([Word])
    }
    
    struct State {
        var words: [Word]?
    }
    
    var initialState = State()
    
    func mutate(action: RubyViewControllerReactor.Action) -> Observable<RubyViewControllerReactor.Mutation> {
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
    
    func reduce(state: RubyViewControllerReactor.State, mutation: RubyViewControllerReactor.Mutation) -> RubyViewControllerReactor.State {
        var state = state
        switch mutation {
        case let .setKanaWords(words):
            state.words = words
        }
        return state
    }
}

