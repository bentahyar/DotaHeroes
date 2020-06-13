//
//  HeroesService.swift
//  DotaHeroes
//
//  Created by Benedict Lukas on 13/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import Foundation
import Alamofire

public class HeroesService {
    public init() {}

    func heroes(onComplete: OnComplete?, onError: OnError?) {
        guard let url = URL(string: ConstantsManager.url) else {
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue

        ServiceManager.api.request(withUrl: urlRequest) { (data, error) in
            if let err = error, err._code == NSURLErrorCancelled {
                onError?(err)
                return
            }

            guard let data = data else { return }

            onComplete?(data)
        }
    }
}
