//
//  ViewController.swift
//  AutoLayoutMission
//
//  Created by MadCow on 2024/2/15.
//

import UIKit

class MissionViewController: UIViewController {

    @IBOutlet weak var secondView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        secondView.layer.cornerRadius = 20
    }
}

