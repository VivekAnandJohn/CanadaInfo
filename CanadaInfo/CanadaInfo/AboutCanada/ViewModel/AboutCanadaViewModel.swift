//
//  AboutCanadaViewModel.swift
//  CanadaInfo
//
//  Created by Vivek John on 01/07/20.
//  Copyright © 2020 developer. All rights reserved.
//

import Foundation

class AboutCanadaViewModel {

    var rowModel: [Row]?
    var titleString = Alert.Network.noData
    
    // MARK: - Webservice Request
    func getAboutCanadaDetails(completion :@escaping (Error?) -> Void) {
        AboutCanadaService().getAboutCanadaDetails { details, error  in
            self.titleString = details.title ?? Alert.Network.noData
            self.rowModel = details.rows
            DispatchQueue.main.async {
                completion(error)
            }
        }
    }
}
