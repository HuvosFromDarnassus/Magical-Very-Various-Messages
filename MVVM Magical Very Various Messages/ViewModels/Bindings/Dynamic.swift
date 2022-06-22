//
//  Dynamic.swift
//  MVVM Magical Very Various Messages
//
//  Created by Daniel Tvorun on 22.06.2022.
//

class Dynamic<T> {
    typealias Listener = (T) -> Void
    private var listener: Listener?
    
    private var value: T {
        didSet {
            listener?(value)
        }
    }
    
    public init(_ v: T) {
        value = v
    }
    
    public func bind(_ listener: Listener?) {
        self.listener = listener
    }
}
