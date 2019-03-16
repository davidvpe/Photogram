//
//  HomeInteractor.swift
//  Photogram
//
//  Created by Velarde Robles, David on 13/03/2019.
//  Copyright (c) 2019 David Velarde. All rights reserved.
//

import UIKit

protocol HomeBusinessLogic {
    func loadPictures(request: Home.LoadPhotos.Request)
    func selectPicture(request: Home.SelectPhoto.Request)
}

protocol HomeDataStore {
    var selectedPhoto: PhotoModel? { get set }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    var presenter: HomePresentationLogic?
    var worker = HomeWorker()
    var photos = [PhotoModel]()
    var selectedPhoto: PhotoModel?

    // MARK: Do something

    func loadPictures(request: Home.LoadPhotos.Request) {

        worker.getAllPhotos(successCompletionHandler: { [weak self] data in
            guard let photos = self?.worker.parsePhotos(data: data) else {
                let response = Home.Error.Response(errorType: .parsingError, description: nil)
                self?.presenter?.presentError(response: response)
                return
            }
            self?.photos = photos
            let response = Home.LoadPhotos.Response(photos: photos)
            self?.presenter?.presentPhotos(response: response)
        }, failureCompletionHandler: { [weak self] errorMessage in
            let response = Home.Error.Response(errorType: .networkError, description: errorMessage)
            self?.presenter?.presentError(response: response)
        })
    }

    func selectPicture(request: Home.SelectPhoto.Request) {
        selectedPhoto = photos[request.selectedIndex]
        let response = Home.SelectPhoto.Response()
        presenter?.presentSelectedPhoto(response: response)
    }
}
