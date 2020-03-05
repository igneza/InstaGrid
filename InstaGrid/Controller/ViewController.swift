//
//  ViewController.swift
//  InstaGrid
//
//  Created by Nda Kwadzo Olivier on 13/02/2020.
//  Copyright © 2020 nksolutions. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var layoutButtons: [UIButton]!
    @IBOutlet var gridButtons: [UIButton]!
    @IBOutlet weak var topLeftgridButton: UIButton!
    @IBOutlet weak var bottomLeftGridButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func layoutButtonTapped(_ sender: UIButton) {
        layoutButtons.forEach { $0.isSelected = false}
        
        // for button in layoutButtons {
        //   button.isSelected = false
        // }
        sender.isSelected = true
        
        switch sender.tag {
        case 0:
            topLeftgridButton.isHidden = true
            bottomLeftGridButton.isHidden = false
        case 1:
            topLeftgridButton.isHidden = false
            bottomLeftGridButton.isHidden = true
        case 2 :
            topLeftgridButton.isHidden = false
            bottomLeftGridButton.isHidden = false
        default:
            break
        }
    }

}

