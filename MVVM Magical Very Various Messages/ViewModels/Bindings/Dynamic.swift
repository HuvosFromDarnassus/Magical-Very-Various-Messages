//
//  Dynamic.swift
//  MVVM Magical Very Various Messages
//
//  Created by Daniel Tvorun on 22.06.2022.
//

class Dynamic<T> {
    typealias Listener = ((String, T, Status)) -> Void
    private var listener: Listener?
    
    var value: (String, T, Status) {
        didSet {
            listener?(value)
        }
    }
    
    public init(_ v: (String, T, Status)) {
        value = v
    }
    
    public func bind(_ listener: Listener?) {
        self.listener = listener
    }
}
