//
//  ViewController.swift
//  InUIKit
//
//  Created by Cain Luo on 2024/1/22.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showSettingView() {
        let view = UIHostingController(rootView: SettingScreen())
        present(view, animated: true)
    }
}
