//
//  HomePresenter.swift
//  Photogram
//
//  Created by Velarde Robles, David on 13/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit

protocol HomePresentationLogic {
    func presentPhotos(response: Home.LoadPictures.Response)
    func presentError(response: Home.Error.Response)
}

class HomePresenter: HomePresentationLogic {
    weak var viewController: HomeDisplayLogic?
    
    // MARK: Do something
    
    func presentPhotos(response: Home.LoadPictures.Response) {

        let photos = response.photos.map { photo -> FeedTableViewCell.ViewModel in
            return FeedTableViewCell.ViewModel(title: photo.title, photoURL: photo.thumbnailUrl, photoId: photo.id)
        }

        let viewModel = Home.LoadPictures.ViewModel(photos: photos)
        viewController?.displayPhotos(viewModel: viewModel)
    }
    func presentError(response: Home.Error.Response) {

    }
}
