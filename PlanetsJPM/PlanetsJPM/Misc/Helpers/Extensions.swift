//
//  Extensions.swift
//  PlanetsJPM
//
//  Created by Dionisis Chatzimarkakis on 18/11/24.
//

import Combine

typealias DisposeBagForCombine = Set<AnyCancellable>
extension DisposeBagForCombine {
    mutating func dispose() {
        forEach { $0.cancel() }
        removeAll()
    }
}
