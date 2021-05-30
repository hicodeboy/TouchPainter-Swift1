//
//  CoordinatingController.swift
//  TouchPainter-Swift1
//
//  Created by hicodeboy on 2021/5/29.
//

import UIKit

class CoordinatingController {
    
    static var instance: CoordinatingController = CoordinatingController()
    
    var canvasViewController: CanvasViewController!
    // 路由处理
    func requestViewChangByObject(sender: Any) {
        if let sender = sender as? UIBarButtonItem {
            
            switch sender.tag {
            case 3:
                let controller = self.controllerWithIdentifier(identifier: "ThumbnailViewController")
                canvasViewController.navigationController?.pushViewController(controller, animated: true)
            case 4:
                let controller = self.controllerWithIdentifier(identifier: "PaletteViewController")
                canvasViewController.navigationController?.pushViewController(controller, animated: true)
            default:
                print(".....")
            }
        } else {
            canvasViewController.navigationController?.popViewController(animated: true)
        }
        
    }
    
    private func controllerWithIdentifier(identifier: String) -> UIViewController {
        let mainStory = UIStoryboard(name: "Main", bundle: nil)
        return mainStory.instantiateViewController(identifier: identifier)
    }
}
