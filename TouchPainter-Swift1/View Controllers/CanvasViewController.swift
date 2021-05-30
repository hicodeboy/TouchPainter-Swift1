//
//  CanvasViewController.swift
//  TouchPainter-Swift1
//
//  Created by hicodeboy on 2021/5/29.
//

import UIKit

class CanvasViewController: UIViewController {
    var canvasView: CanvasView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置中介者画板对象
        CoordinatingController.instance.canvasViewController = self
        let defaultGenerator = CanvasViewGenerator()
        
        loadCanvasView(with: defaultGenerator)
        
    }
    
    func loadCanvasView(with generator: CanvasViewGenerator) {
        canvasView?.removeFromSuperview()
        let aFrame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 64)
        let aCanvasView = generator.canvasView(with: aFrame)

        self.canvasView = aCanvasView
//        self.canvasView.backgroundColor = .red
        let viewIndex = self.view.subviews.count - 1
        
        self.view.insertSubview(self.canvasView ?? aCanvasView, at: viewIndex)

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /// 将要显示时将导航条隐藏
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        /// 将要消失时将导航条显示
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
