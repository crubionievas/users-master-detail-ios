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
    @IBOutlet var userEmail: UIButton!
    @IBOutlet var userPhone: UIButton!
    @IBOutlet var userCell: UIButton!
    
    var user: User = User()
    let kButtonPhoneTag = 100
    let kButtonCellTag = 101

    func configureView() {
        // Update the user interface for the detail item.
        if let user = detailItem {
            self.user = user
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
            
            if let button = userEmail {
                button.setTitle(user.email, for: .normal)
            }
            
            if let button = userPhone {
                button.setTitle(user.phone, for: .normal)
                button.tag = kButtonPhoneTag
            }
            
            if let button = userCell {
                button.setTitle(user.cell, for: .normal)
                button.tag = kButtonCellTag
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

    @IBAction func emailButtonClicked(_ sender: Any) {
        if let email = user.email {
            if let url = URL(string: "mailto:\(email)") {
                UIApplication.shared.open(url, options: [:], completionHandler: {
                    (success) in
                    print("User wants to send email to \(email)")
                    
                })
            }
        }
    }
    

    @IBAction func phoneButtonClicked(_ sender: Any) {
        var phoneNumber: String?
        if let sender = sender as? UIButton {
            switch sender.tag {
            case kButtonPhoneTag:
                phoneNumber = user.phone
            case kButtonCellTag:
                phoneNumber = user.cell
            default:
                phoneNumber = user.phone
            }
        }
        
        if let phone = phoneNumber {
            if (callNumber(phone)) {
                print("User wants to call \(phone)")
            }
        }
    }
    
    func callNumber(_ phoneNumber: String) -> Bool {
        
        guard
            let phoneCallURL: URL = URL(string: "tel://\(phoneNumber)"),
            UIApplication.shared.canOpenURL(phoneCallURL)
            else { return false }
        
        UIApplication.shared.open(phoneCallURL, options: [:], completionHandler: nil)
        return true
    }
}

