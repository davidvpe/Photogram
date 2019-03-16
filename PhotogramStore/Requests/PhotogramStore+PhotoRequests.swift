//
//  PhotogramStore+AlbumRequests.swift
//  PhotogramStore
//
//  Created by Velarde Robles, David on 13/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import Foundation

public protocol PhotoRequests: class {
    func getPhotos(completionHandler: @escaping NetworkManagerDataHandler)
    func getPhotos(byAlbumId albumId: String, completionHandler: @escaping NetworkManagerDataHandler)
}

extension PhotogramStore: PhotoRequests {

    public func getPhotos(completionHandler: @escaping NetworkManagerDataHandler) {
        internalGetPhotos(completionHandler: completionHandler)
    }

    public func getPhotos(byAlbumId albumId: String, completionHandler: @escaping NetworkManagerDataHandler) {
        internalGetPhotos(byAlbumId: albumId, completionHandler: completionHandler)
    }

    private func internalGetPhotos(byAlbumId albumId: String? = nil, completionHandler: @escaping NetworkManagerDataHandler) {

        let url = baseURL + "photos"

        var params = [Parameter]()

        if let albumId = albumId {
            params.append(Parameter("albumId", albumId))
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
