//
//  PhotogramStore+PhotoRequests.swift
//  PhotogramStore
//
//  Created by Velarde Robles, David on 13/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import Foundation

public protocol AlbumRequests: class {
    func getAlbums(byUserId userId: String, completionHandler: @escaping NetworkManagerDataHandler)
    func getAlbums(completionHandler: @escaping NetworkManagerDataHandler)
}

extension PhotogramStore: AlbumRequests {

    public func getAlbums(completionHandler: @escaping NetworkManagerDataHandler) {
        internalGetAlbums(completionHandler: completionHandler)
    }

    public func getAlbums(byUserId userId: String, completionHandler: @escaping NetworkManagerDataHandler) {
        internalGetAlbums(byUserId: userId, completionHandler: completionHandler)
    }

    private func internalGetAlbums(byUserId userId: String? = nil, completionHandler: @escaping NetworkManagerDataHandler) {
        let url = baseURL + "albums"

        var params = [Parameter]()

        if let userId = userId {
            params.append(Parameter("userId", userId))
        }

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
