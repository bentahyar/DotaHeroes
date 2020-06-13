//
//  ServiceManager.swift
//  DotaHeroes
//
//  Created by Benedict Lukas on 13/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import Foundation
import Alamofire

public typealias OnComplete = (Data?) -> Void
public typealias OnError = (Error?) -> Void

public class ServiceManager {
    private static var sharedInstance: ServiceManager?
    public class var api: ServiceManager {
        if let sharedInstance = self.sharedInstance {
            return sharedInstance
        }

        fatalError("ServiceManager is not initialized")
    }

    func request(withUrl url: URLRequestConvertible,
                 completion: ((Data?, Error?) -> Void)?) {
        AF.request(url).validate().responseData { response in
            switch response.result {
            case let .success(data):
                completion?(data, nil)
            case let .failure(error):
                completion?(nil, error)
            }
        }
    }
}
