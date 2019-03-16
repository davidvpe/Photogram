//
//  AlbumFeedPresenter.swift
//  Photogram
//
//  Created by Velarde Robles, David on 15/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit

protocol AlbumFeedPresentationLogic {
    func presentAlbums(response: AlbumFeed.LoadAlbums.Response)
    func presentError(response: AlbumFeed.Error.Response)
    func presentSelectedAlbum(response: AlbumFeed.SelectAlbum.Response)
}

class AlbumFeedPresenter: AlbumFeedPresentationLogic {
    weak var viewController: AlbumFeedDisplayLogic?

    // MARK: Do something

    func presentAlbums(response: AlbumFeed.LoadAlbums.Response) {

        let albums = response.albums.map { album -> FeedTableViewCell.ViewModel in
            return FeedTableViewCell.ViewModel(title: album.title, albumId: album.id)
        }

        let viewModel = AlbumFeed.LoadAlbums.ViewModel(albums: albums)
        viewController?.displayAlbums(viewModel: viewModel)
    }
    func presentError(response: AlbumFeed.Error.Response) {
        var errorMessage = ""
        switch response.errorType {
        case .networkError:
            errorMessage = response.description ?? ""
        case .parsingError:
            errorMessage = "There's been an error parsing the data"
        }
        let viewModel = AlbumFeed.Error.ViewModel(description: errorMessage)
        viewController?.displayError(viewModel: viewModel)
    }

    func presentSelectedAlbum(response: AlbumFeed.SelectAlbum.Response) {
        let viewModel = AlbumFeed.SelectAlbum.ViewModel()
        viewController?.displaySelectedAlbum(viewModel: viewModel)
    }
}
