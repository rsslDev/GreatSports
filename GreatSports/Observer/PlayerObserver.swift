//
//  PlayerObserver.swift
//  GreatSports
//
//  Created by Russel Dev on 25/07/23.
//

import Foundation

final class PlayerObserver<T> {
    typealias Listener = (T) -> Void
  
    var listener: Listener?
    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
