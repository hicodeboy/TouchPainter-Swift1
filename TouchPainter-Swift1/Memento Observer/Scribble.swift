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
    
    init(with memento: Any) {
        
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
    
    
    
}
