//
//  AlbumFeedInteractor.swift
//  Photogram
//
//  Created by Velarde Robles, David on 15/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit

protocol AlbumFeedBusinessLogic {
    func doSomething(request: AlbumFeed.Something.Request)
}

protocol AlbumFeedDataStore { }

class AlbumFeedInteractor: AlbumFeedBusinessLogic, AlbumFeedDataStore {
    var presenter: AlbumFeedPresentationLogic?
    var worker: AlbumFeedWorker?
    
    // MARK: Do something
    
    func doSomething(request: AlbumFeed.Something.Request) {
        worker = AlbumFeedWorker()
        worker?.doSomeWork()
        
        let response = AlbumFeed.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
