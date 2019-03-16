//
//  AlbumInteractor.swift
//  Photogram
//
//  Created by Velarde Robles, David on 15/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit

protocol AlbumBusinessLogic {
    func doSomething(request: Album.Something.Request)
}

protocol AlbumDataStore { }

class AlbumInteractor: AlbumBusinessLogic, AlbumDataStore {
    var presenter: AlbumPresentationLogic?
    var worker = AlbumWorker()

    // MARK: Do something

    func doSomething(request: Album.Something.Request) {
        
        let response = Album.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
