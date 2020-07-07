//
//  Alert.swift
//  CanadaInfo
//
//  Created by Vivek John on 07/07/20.
//  Copyright © 2020 developer. All rights reserved.
//

import UIKit

struct Alert {
    struct Network {
        static let title = "Network Error"
        static let message = "Please check your Internet Connection"
        static let noData = "Data Unavailable"
    }
    
    static func present(title: String?, message: String, actions: Alert.Action..., from controller: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alertController.addAction(action.alertAction)
        }
        controller.present(alertController, animated: true, completion: nil)
    }
}
