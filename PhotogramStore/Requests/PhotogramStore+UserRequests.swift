//
//  PhotogramStore+UserRequests.swift
//  PhotogramStore
//
//  Created by Velarde Robles, David on 16/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import Foundation

public protocol UserRequests: class {
    func getUsers(completionHandler: @escaping NetworkManagerDataHandler)
}

extension PhotogramStore: UserRequests {

    public func getUsers(completionHandler: @escaping NetworkManagerDataHandler) {
        let url = baseURL + "users"

        let params = [Parameter]()

        let operation = NetworkOperation(url, params: params, finishedBlock: { result in
            switch result {
            case .data(let data):
                if let data = data {
                    completionHandler(.success(response: data))
                } else {
                    completionHandler(.failure(description: "No data"))
                }
            case .error(let description):
                if let description = description {
                    completionHandler(.failure(description: description))
                } else {
                    completionHandler(.failure(description: "Unknown Error"))
                }
            }
        })

        enqueueOperationWithDependancies(operation: operation)
    }
}
