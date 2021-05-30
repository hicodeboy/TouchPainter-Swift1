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
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: m, requiringSecureCoding: false)
            return data
        } catch {
            return nil
        }
    }
    
    func memento(with data: Data) -> ScribbleMemento? {
        do {
            let retoredMark = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
            return ScribbleMemento(with: retoredMark as? Mark)
        } catch {
            return nil
        }
    }
    
    
}
