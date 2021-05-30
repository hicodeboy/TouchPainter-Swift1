//
//  Scribble.swift
//  TouchPainter-Swift1
//
//  Created by hicodeboy on 2021/5/30.
//

import Foundation

class Scribble: NSObject {
    @objc var mark = Stroke()
    var incrementalMark: Mark?
    
    override init() {
        super.init()
    }
    
    init(with memento: ScribbleMemento) {
        super.init()
        if (memento.hasCompleteSnapshot) {
            self.mark = memento.mark as! Stroke
        } else {
            self.mark = Stroke()
            self.attachState(from: memento)
        }
    }
    
    func add(mark: Mark, shouldAddToPreviousMark: Bool) {
        self.willChangeValue(forKey: "mark")
        if (shouldAddToPreviousMark) {
            self.mark.lastChild()?.addMark(mark: mark)
        } else {
            self.mark.addMark(mark: mark)
            self.incrementalMark = mark
        }
        self.didChangeValue(forKey: "mark")
    }
    
    func remove(amark: Mark?) {
        guard let m = amark else { return }
        self.willChangeValue(forKey: "mark")
        mark.remove(mark: m)
        if (mark == self.incrementalMark) {
            self.incrementalMark = nil
        }
        self.didChangeValue(forKey: "mark")
    }
    
    func attachState(from memento:ScribbleMemento?) {
        guard let m = memento else { return }
        self.add(mark: m.mark!, shouldAddToPreviousMark: false)
    }
    
    func scribbleMementoWithCompleteSnapshot(hasCompleteSnapshot: Bool) -> ScribbleMemento? {
        // 如果incrementalMark 为 nil，我们什么也做不了， 直接退出即可
        guard let iMark = self.incrementalMark else { return nil }
        var mementoMark = iMark
        // 如果要求返回完整的快照，就把它设置为mark
        if (hasCompleteSnapshot) {
            mementoMark = self.mark
        }
        
        let memento = ScribbleMemento(with: mementoMark)
        memento.hasCompleteSnapshot = hasCompleteSnapshot
        return memento
    }
    
    func scribbleMemento() -> ScribbleMemento? {
        return self.scribbleMementoWithCompleteSnapshot(hasCompleteSnapshot: true)
    }
    
    static func scribble(with memento: ScribbleMemento) -> Scribble {
        return Scribble(with: memento)
    }
    
}
