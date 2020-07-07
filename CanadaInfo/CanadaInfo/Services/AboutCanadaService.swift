//
//  AboutCanadaService.swift
//  CanadaInfo
//
//  Created by Vivek John on 07/07/20.
//  Copyright © 2020 developer. All rights reserved.
//

import Foundation

class AboutCanadaService {
    
    // MARK: - Webservice Request
    func getAboutCanadaDetails(completionHandler: @escaping (AboutCanadaModel, Error?) -> Void) {
        //url
        guard let url = URL(string: API.urlAboutCanada) else { return }

        //requesting for data
        let service = BaseService()
        service.request(for: url) { (result: Result<AboutCanadaModel, Error>) in
            switch result {
            case .success(let details):
                completionHandler(details, nil)
            case .failure(let error):
                //finding error
                completionHandler(AboutCanadaModel(), error)
                print(error)
            }
        }
    }
}
