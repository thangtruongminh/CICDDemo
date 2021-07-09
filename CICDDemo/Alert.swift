//
//  Alert.swift
//  CICDDemo
//
//  Created by Thang Truong on 09/07/2021.
//

import Foundation
//
//  ShowAlert.swift
//  Hosee
//
//  Created by Duc Anh on 4/11/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

func showAlertToOpenAppSetting(viewController: UIViewController? = nil,
                               title: String, message: String) -> UIAlertController {
    return showAlertCompelete(viewController: viewController,
                              title: title,
                              message: message,
                              settingUrl: UIApplication.openSettingsURLString)
}

func showCustomAlert(viewController: UIViewController? = nil,
                     title: String,
                     message: String,
                     okTitle: String,
                     cancleTitle: String? = nil,
                     okHandle: (() -> Void)? = nil,
                     cancleHandle: (() -> Void)? = nil) -> UIAlertController {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    let okAction = UIAlertAction(title: okTitle, style: .default, handler: { (_) in
        okHandle?()
    })
    alertController.addAction(okAction)
    if let cancleTitle = cancleTitle {
        let cancelAction = UIAlertAction(title: cancleTitle, style: .cancel, handler: { (_) in
            cancleHandle?()
        })
        alertController.addAction(cancelAction)
    }
    if let viewController = viewController {
        viewController.present(alertController, animated: true, completion: nil)
    } else {
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    return alertController
}

func showAlert(viewController: UIViewController? = nil,
               title: String,
               message: String,
               completeHandler: (() -> Void)? = nil) -> UIAlertController {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) { (result: UIAlertAction) -> Void in
        completeHandler?()
    }
    alertController.addAction(okAction)
    if let viewController = viewController {
        viewController.present(alertController, animated: true, completion: nil)
    } else {
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    return alertController
}

func showAlertCompelete(viewController: UIViewController? = nil,
                        title: String,
                        message: String,
                        settingUrl: String) -> UIAlertController {
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    let settingAction = UIAlertAction(title: "Setting", style: .cancel) { (_) -> Void in
        guard let settingsUrl = URL(string: settingUrl) else {
            return
        }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(settingsUrl, completionHandler: nil)
            } else {
                UIApplication.shared.openURL(settingsUrl)
            }
        }
    }
    let okAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) { (result: UIAlertAction) -> Void in
    }
    alertController.addAction(okAction)
    alertController.addAction(settingAction)
    if let viewController = viewController {
        viewController.present(alertController, animated: true, completion: nil)
    } else {
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    return alertController
}

