//
//  AlbumFeedPresenter.swift
//  Photogram
//
//  Created by Velarde Robles, David on 15/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit

protocol AlbumFeedPresentationLogic {
    func presentSomething(response: AlbumFeed.Something.Response)
}

class AlbumFeedPresenter: AlbumFeedPresentationLogic {
    weak var viewController: AlbumFeedDisplayLogic?

    // MARK: Do something

    func presentSomething(response: AlbumFeed.Something.Response) {
        let viewModel = AlbumFeed.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
