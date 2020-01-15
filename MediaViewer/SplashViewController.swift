//
//  SplashViewController.swift
//  MediaViewer
//
//  Created by Jan Carlo Aterrado on 13/01/2020.
//  Copyright © 2020 Jan Carlo Aterrado. All rights reserved.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(
            timeInterval: 2.5,
            target: self,
            selector: #selector(showMasterView),
            userInfo: nil, repeats: false
        )
    }
    
    @objc func showMasterView() {
        self.performSegue(withIdentifier: "showMaster",
                          sender: self)
    }
}
