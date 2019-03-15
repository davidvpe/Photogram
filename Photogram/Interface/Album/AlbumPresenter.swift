//
//  AlbumPresenter.swift
//  Photogram
//
//  Created by Velarde Robles, David on 15/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit

protocol AlbumPresentationLogic {
    func presentSomething(response: AlbumModel.Something.Response)
}

class AlbumPresenter: AlbumPresentationLogic {
    weak var viewController: AlbumDisplayLogic?

    // MARK: Do something

    func presentSomething(response: AlbumModel.Something.Response) {
        let viewModel = AlbumModel.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
