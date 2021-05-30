//
//  DeleteScribbleCommand.swift
//  TouchPainter-Swift1
//
//  Created by hicodeboy on 2021/5/30.
//

import Foundation

class DeleteScribbleCommand: Command {
    override func execute() {
        let coordinator = CoordinatingController.instance
        let controller = coordinator.canvasViewController
        
        let newScribble = Scribble()
        controller?.setScribble(newScribble)
        
    }
}
