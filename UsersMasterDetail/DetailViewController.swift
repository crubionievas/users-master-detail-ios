//
//  DetailViewController.swift
//  UsersMasterDetail
//
//  Created by Carlos Rubio on 07/03/2019.
//  Copyright © 2019 Carlos Rubio. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    func configureView() {
        // Update the user interface for the detail item.
        if let user = detailItem {
            if let label = detailDescriptionLabel {
                label.text = user.email
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    var detailItem: User? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

