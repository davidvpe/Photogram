//
//  HomeInteractor.swift
//  Photogram
//
//  Created by Velarde Robles, David on 13/03/2019.
//  Copyright (c) 2019 David Velarde. All rights reserved.
//

import UIKit

protocol HomeBusinessLogic {
    func doSomething(request: Home.Something.Request)
}

protocol HomeDataStore { }

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    var presenter: HomePresentationLogic?
    var worker: HomeWorker?

    // MARK: Do something

    func doSomething(request: Home.Something.Request) {
        worker = HomeWorker()
        worker?.doSomeWork()

        let response = Home.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
