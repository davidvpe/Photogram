//
//  HomeInteractor.swift
//  Photogram
//
//  Created by Velarde Robles, David on 13/03/2019.
//  Copyright (c) 2019 David Velarde. All rights reserved.
//

import UIKit

protocol HomeBusinessLogic {
    func loadPictures(request: Home.LoadPictures.Request)
}

protocol HomeDataStore { }

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    var presenter: HomePresentationLogic?
    var worker = HomeWorker()

    // MARK: Do something

    func loadPictures(request: Home.LoadPictures.Request) {

        worker.getAllPhotos(successCompletionHandler: { data in
            guard let photos = self.worker.parsePhotos(data: data) else {
                let response = Home.Error.Response(errorType: .parsingError, description: nil)
                self.presenter?.presentError(response: response)
                return
            }
            let response = Home.LoadPictures.Response(photos: photos)
            self.presenter?.presentPhotos(response: response)
        }, failureCompletionHandler: { errorMessage in
            let response = Home.Error.Response(errorType: .networkError, description: errorMessage)
            self.presenter?.presentError(response: response)
        })
    }
}
