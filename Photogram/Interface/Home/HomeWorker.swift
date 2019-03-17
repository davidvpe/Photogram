//
//  HomeWorker.swift
//  Photogram
//
//  Created by Velarde Robles, David on 13/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit
import PhotogramStore

typealias SuccessCompletionHandler = (Data) -> ()
typealias FailureCompletionHandler = (String) -> ()

class HomeWorker {
    func getAllPhotos(successCompletionHandler: @escaping SuccessCompletionHandler,
                      failureCompletionHandler: @escaping FailureCompletionHandler) {
        
        PhotogramStore.shared.getPhotos { result in
            switch result {
            case .success(let data):
                successCompletionHandler(data)
            case .failure(let description):
                failureCompletionHandler(description)
            }
        }
    }

    func getAllPhotos(forAlbumId albumId: Int,
                      successCompletionHandler: @escaping SuccessCompletionHandler,
                      failureCompletionHandler: @escaping FailureCompletionHandler) {

        PhotogramStore.shared.getPhotos(byAlbumId: albumId) { result in
            switch result {
            case .success(let data):
                successCompletionHandler(data)
            case .failure(let description):
                failureCompletionHandler(description)
            }
        }
    }

    func parsePhotos(data: Data) -> [PhotoModel]? {
        return try? JSONDecoder().decode([PhotoModel].self, from: data)
    }
}
