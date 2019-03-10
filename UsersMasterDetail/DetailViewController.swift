//
//  DetailViewController.swift
//  UsersMasterDetail
//
//  Created by Carlos Rubio on 07/03/2019.
//  Copyright © 2019 Carlos Rubio. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailViewController: UIViewController {

    @IBOutlet var userImage: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var userEmail: UILabel!
    @IBOutlet var userPhone: UILabel!
    @IBOutlet var userCell: UILabel!

    func configureView() {
        // Update the user interface for the detail item.
        if let user = detailItem {
            // Download image
            if let imageUrl = user.picture?.large {
                if let url = URL(string: imageUrl) {
                    if let image = userImage {
                        image.af_setImage(withURL: url)
                    }
                }
            }
            
            if let label = userName {
                label.text = user.name?.getFullName()
            }
            
            if let label = userEmail {
                label.text = user.email
            }
            
            if let label = userPhone {
                label.text = user.phone
            }
            
            if let label = userCell {
                label.text = user.cell
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

