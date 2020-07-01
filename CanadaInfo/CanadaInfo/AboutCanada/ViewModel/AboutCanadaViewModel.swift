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
    var titleString = "No Data"
    
    // MARK: - Webservice Request
    func getAboutCanadaDetails(completionHandler: @escaping (Error?) -> Void) {
        //url
        guard let url = URL(string: API.urlAboutCanada) else { return }

        //requesting for data
        let service = BaseService()
        service.request(for: url) { (result: Result<AboutCanadaModel, Error>) in
            switch result {
            case .success(let details):
                if let title = details.title {
                    self.titleString = title
                }
                if let rows = details.rows {
                    self.rowModel = rows
                }
                completionHandler(nil)
            case .failure(let error):
                //finding error
                print(error)
            }
        }
    }
}
