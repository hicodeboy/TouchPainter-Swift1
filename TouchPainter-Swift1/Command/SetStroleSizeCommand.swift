//
//  SetStroleSizeCommand.swift
//  TouchPainter-Swift1
//
//  Created by hicodeboy on 2021/5/29.
//

import UIKit

protocol SetStrokeSizeCommandDelegate: class {
    func command(_ command: SetStrokeSizeCommand, size: inout Float)
}

class SetStrokeSizeCommand: Command {
    weak var delegate: SetStrokeSizeCommandDelegate?
    override func execute() {
        /// TODO 待实现给 canvas传值
        guard let delegate = delegate else { return }
        var strokeSize: Float = 1.0
        delegate.command(self, size: &strokeSize)
        
        let coordinator = CoordinatingController.instance
        let controler = coordinator.canvasViewController
        controler?.strokeSize = CGFloat(strokeSize)
    }
}
