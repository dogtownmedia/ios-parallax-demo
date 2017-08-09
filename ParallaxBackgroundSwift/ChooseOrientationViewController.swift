//
//  ChooseOrientationViewController.swift
//  ParallaxBackgroundSwift
//
//  Created by Justin Hall on 8/8/17.
//  Copyright © 2017 jhall. All rights reserved.
//

import UIKit

class ChooseOrientationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HorizontalSegue" {
            guard let destinationViewController = segue.destination as? ViewController else { return }
            destinationViewController.scrollingDirection = .left
        } else if segue.identifier == "VerticalSegue" {
            guard let destinationViewController = segue.destination as? ViewController else { return }
            destinationViewController.scrollingDirection = .down
        }
    }
 
}
