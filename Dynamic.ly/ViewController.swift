//
//  ViewController.swift
//  Dynamic.ly
//
//  Created by Vignesh on 11/08/22.
//

import UIKit
import CustomViewPresenter

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let newVC = NewVC()
        self.interactivelyPresent(newVC, animated: true) {
        }
    }
}

class NewVC: UIViewController, CustomViewPresentable {
    func didChangeToFullScreen() {
        
    }
    
    var heightForMiniMode: CGFloat? = UIScreen.main.bounds.height * 0.4
    
    lazy var customView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    override func loadView() {
        view = customView
    }
}

