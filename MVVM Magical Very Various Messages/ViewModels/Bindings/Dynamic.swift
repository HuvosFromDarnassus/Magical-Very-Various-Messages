//
//  Dynamic.swift
//  MVVM Magical Very Various Messages
//
//  Created by Daniel Tvorun on 22.06.2022.
//

class Dynamic {
    typealias Listener = ((String, Status)) -> Void
    private var listener: Listener?
    
    var value: (String, Status) {
        didSet {
            listener?(value)
        }
    }
    
    public init(_ v: (String, Status)) {
        value = v
    }
    
    public func bind(_ listener: Listener?) {
        self.listener = listener
    }
}
