//
//  BaseUIViewController.swift
//  business
//
//  Created by Rahmat Hidayat on 10/12/22.
//

import Foundation
import UIKit

class BaseUIViewController: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI() {
        self.view.backgroundColor = .white
    }
}
