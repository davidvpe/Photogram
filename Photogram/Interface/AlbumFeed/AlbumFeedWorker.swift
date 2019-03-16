//
//  AlbumFeedWorker.swift
//  Photogram
//
//  Created by Velarde Robles, David on 15/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit
import PhotogramStore

class AlbumFeedWorker {
    func getAllAlbums(successCompletionHandler: @escaping SuccessCompletionHandler,
                      failureCompletionHandler: @escaping FailureCompletionHandler) {

        PhotogramStore.shared.getAlbums { (result) in
            switch result {
            case .success(let data):
                successCompletionHandler(data)
            case .failure(let description):
                failureCompletionHandler(description)
            }
        }
    }

    func parseAlbums(data: Data) -> [AlbumModel]? {
        return try? JSONDecoder().decode([AlbumModel].self, from: data)
    }
}
