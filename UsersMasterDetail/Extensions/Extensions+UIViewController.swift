//
//  Extensions+UIViewController.swift
//  UsersMasterDetail
//
//  Created by Carlos Rubio on 09/03/2019.
//  Copyright © 2019 Carlos Rubio. All rights reserved.
//
import UIKit

extension UIViewController {
    func showProgress(_ enabled: Bool) {
        DispatchQueue.main.async {
            // Remove any existing activity indicator
            for view in self.view.subviews {
                if view is UIActivityIndicatorView {
                    view.removeFromSuperview()
                }
            }
            
            guard enabled else {
                return
            }
            
            // Add a new activity indicator
            let indicator = UIActivityIndicatorView(style: .whiteLarge)
            let backgroundView = UIView(frame: CGRect(
                x: -indicator.frame.width/2 ,
                y: -indicator.frame.width/2,
                width: indicator.frame.width*2,
                height: indicator.frame.width*2))
            backgroundView.backgroundColor = .gray
            backgroundView.layer.cornerRadius = 3.5
            indicator.insertSubview(backgroundView, at: 0)
            
            let size = indicator.frame.size
            
            let screen = UIScreen.main
                .bounds
            
            let frameX = screen.midX - (size.width/2)
            var frameY = screen.midY - (size.height/2)
            
            if let navigationBarHeight = self.navigationController?.navigationBar.bounds.height {
                frameY -= navigationBarHeight
            }
            
            indicator.frame = CGRect(
                x: frameX,
                y: frameY,
                width: size.width,
                height: size.height)
            
            
            indicator.color = .darkGray
            indicator.startAnimating()
            self.view.addSubview(indicator)
        }
    }
}

