//
//  Extensions.swift
//  CanadaInfo
//
//  Created by Vivek John on 07/07/20.
//  Copyright © 2020 developer. All rights reserved.
//

import UIKit

extension Alert {
    enum Action {
        case retry(handler: (() -> Void)?)
        case close

        // Returns the title of our action button
        private var title: String {
            switch self {
            case .retry:
                return "Retry"
            case .close:
                return "Ok"
            }
        }

        // Returns the completion handler of our button
        private var handler: (() -> Void)? {
            switch self {
            case .retry(let handler):
                return handler
            case .close:
                return nil
            }
        }

        var alertAction: UIAlertAction {
            return UIAlertAction(title: title, style: .default, handler: { _ in
                if let handler = self.handler {
                    handler()
                }
            })
        }
    }
}
