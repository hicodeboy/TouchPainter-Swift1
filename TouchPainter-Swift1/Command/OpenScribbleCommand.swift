//
//  OpenScribbleCommand.swift
//  TouchPainter-Swift1
//
//  Created by hicodeboy on 2021/5/30.
//

import Foundation

class OpenScribbleCommand: Command {
    var scribbleSource: ScribbleSource
    
    init(scribbleSource: ScribbleSource) {
        self.scribbleSource = scribbleSource
    }
    
    override func execute() {
        guard let scribble = scribbleSource.getScribble()  else { return }
        
        let coordinator = CoordinatingController.instance
        let controller = coordinator.canvasViewController
        controller?.setScribble(scribble)
        coordinator.requestViewChangByObject(sender: self)
    }
}
