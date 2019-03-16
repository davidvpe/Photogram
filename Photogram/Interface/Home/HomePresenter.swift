//
//  HomePresenter.swift
//  Photogram
//
//  Created by Velarde Robles, David on 13/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit

protocol HomePresentationLogic {
    func presentPhotos(response: Home.LoadPhotos.Response)
    func presentError(response: Home.Error.Response)
    func presentSelectedPhoto(response: Home.SelectPhoto.Response)
}

class HomePresenter: HomePresentationLogic {
    weak var viewController: HomeDisplayLogic?
    
    // MARK: Do something
    
    func presentPhotos(response: Home.LoadPhotos.Response) {

        let photos = response.photos.map { photo -> PhotoCollectionViewCell.ViewModel in
            return PhotoCollectionViewCell.ViewModel(title: photo.title, photoURL: photo.thumbnailUrl, photoId: photo.id)
        }

        let viewModel = Home.LoadPhotos.ViewModel(photos: photos)
        viewController?.displayPhotos(viewModel: viewModel)
    }
    func presentError(response: Home.Error.Response) {
        var errorMessage = ""
        switch response.errorType {
        case .networkError:
            errorMessage = response.description ?? ""
        case .parsingError:
            errorMessage = "There's been an error parsing the data"
        }
        let viewModel = Home.Error.ViewModel(description: errorMessage)
        viewController?.displayError(viewModel: viewModel)
    }

    func presentSelectedPhoto(response: Home.SelectPhoto.Response) {
        let viewModel = Home.SelectPhoto.ViewModel()
        viewController?.displaySelectedPhoto(viewModel: viewModel)
    }
}
