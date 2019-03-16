//
//  AlbumPresenter.swift
//  Photogram
//
//  Created by Velarde Robles, David on 15/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit

protocol AlbumPresentationLogic {
    func presentSomething(response: Album.Something.Response)
}

class AlbumPresenter: AlbumPresentationLogic {
    weak var viewController: AlbumDisplayLogic?

    // MARK: Do something

    func presentSomething(response: Album.Something.Response) {
        let viewModel = Album.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
