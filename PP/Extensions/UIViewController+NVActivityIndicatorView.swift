//
//  UIViewController+NVActivityIndicatorView.swift
//  PP
//
//  Created by Алексей on 04.03.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

extension UIViewController: NVActivityIndicatorViewable{
    
    func showActivityIndicatory() {
        NVActivityIndicatorView.DEFAULT_TYPE = .pacman
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor.yellow
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
    func hideActivityIndicatory() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
}
