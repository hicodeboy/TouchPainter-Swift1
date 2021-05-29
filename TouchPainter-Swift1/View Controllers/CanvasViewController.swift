//
//  CanvasViewController.swift
//  TouchPainter-Swift1
//
//  Created by hicodeboy on 2021/5/29.
//

import UIKit

class CanvasViewController: UIViewController {
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
