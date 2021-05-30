//
//  SaveScribbleCommand.swift
//  TouchPainter-Swift1
//
//  Created by hicodeboy on 2021/5/30.
//

import UIKit

class SaveScribbleCommand: Command {
    override func execute() {
        let coordinatingController = CoordinatingController.instance
        let canvasViewController = coordinatingController.canvasViewController
        
        let alert = UIAlertController(title: "要保存涂鸦吗？", message: nil, preferredStyle: .alert)
        let conform = UIAlertAction(title: "确认", style: .default) { (action) in
            let canvasViewImage = canvasViewController?.canvasView?.image()
            let scribble = canvasViewController?.scribble
            let scribbleManager = ScribbleManager()
            scribbleManager.save(scribble: scribble!, thumbnail: canvasViewImage!)
        }
        
        let cancel = UIAlertAction(title: "取消", style: .default) { (action) in
            print("取消保存涂鸦")
        }
        alert.addAction(conform)
        alert.addAction(cancel)
        
        canvasViewController?.present(alert, animated: true, completion: {
        })
    }
}
