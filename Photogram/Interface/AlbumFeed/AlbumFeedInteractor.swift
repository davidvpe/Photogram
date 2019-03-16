//
//  AlbumFeedInteractor.swift
//  Photogram
//
//  Created by Velarde Robles, David on 15/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit

protocol AlbumFeedBusinessLogic {
    func loadAlbums(request: AlbumFeed.LoadAlbums.Request)
    func selectAlbum(request: AlbumFeed.SelectAlbum.Request)
}

protocol AlbumFeedDataStore {
    var selectedAlbum: AlbumModel? { get set }
}

class AlbumFeedInteractor: AlbumFeedBusinessLogic, AlbumFeedDataStore {
    var presenter: AlbumFeedPresentationLogic?
    var worker = AlbumFeedWorker()
    var selectedAlbum: AlbumModel?
    var albums = [AlbumModel]()
    
    // MARK: Do something
    
    func loadAlbums(request: AlbumFeed.LoadAlbums.Request) {

        worker.getAllAlbums(successCompletionHandler: { [weak self] data in

            guard let albums = self?.worker.parseAlbums(data: data) else {

                let response = AlbumFeed.Error.Response(errorType: .parsingError, description: nil)
                self?.presenter?.presentError(response: response)
                return
            }

            self?.albums = albums

            let response = AlbumFeed.LoadAlbums.Response(albums: albums)
            self?.presenter?.presentAlbums(response: response)

        }, failureCompletionHandler: { [weak self] errorMessage in

            let response = AlbumFeed.Error.Response(errorType: .networkError, description: errorMessage)
            self?.presenter?.presentError(response: response)
        })
    }

    func selectAlbum(request: AlbumFeed.SelectAlbum.Request) {
        selectedAlbum = albums[request.selectedIndex]
        let response = AlbumFeed.SelectAlbum.Response()
        presenter?.presentSelectedAlbum(response: response)
    }
}
