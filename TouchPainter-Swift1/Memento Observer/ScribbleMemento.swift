//
//  ScribbleMemento.swift
//  TouchPainter-Swift1
//
//  Created by hicodeboy on 2021/5/30.
//

import Foundation

class ScribbleMemento {
    var hasCompleteSnapshot = false
    var mark: Mark?
    init(with mark: Mark?) {
        self.mark = mark
    }
    
    func data() -> Data? {
        guard let m = mark else { return nil }
    }
    
    
}
