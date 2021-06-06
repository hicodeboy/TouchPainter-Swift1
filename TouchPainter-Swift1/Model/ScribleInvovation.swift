//
//  ScribleInvovation.swift
//  TouchPainter-Swift1
//
//  Created by hicodeboy on 2021/6/6.
//

import Foundation

struct ScribleInvocation {
    var mark: Mark?
    init() {
    }
    struct UndoAction {
        let undo: ScribleInvocation
        let redo: ScribleInvocation
    }
    
    func action(undo: ScribleInvocation) -> UndoAction {
        return UndoAction(undo: undo, redo: self)
    }
    
    func undo(with scrible: Scribble) {
        scrible.remove(amark: mark)
    }
    
    func redo(with scrible: Scribble) {
        guard let mark = mark else { return }
        scrible.add(mark: mark, shouldAddToPreviousMark: false)
    }
}
