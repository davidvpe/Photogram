//
//  AlbumFeedRouter.swift
//  Photogram
//
//  Created by Velarde Robles, David on 15/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit

@objc protocol AlbumFeedRoutingLogic {
    func routeToSelectedAlbum()
}

protocol AlbumFeedDataPassing {
    var dataStore: AlbumFeedDataStore? { get }
}

class AlbumFeedRouter: NSObject, AlbumFeedRoutingLogic, AlbumFeedDataPassing {
    weak var viewController: AlbumFeedViewController?
    var dataStore: AlbumFeedDataStore?

    // MARK: Routing
    func routeToSelectedAlbum() {
        let destinationVC = HomeViewController()
        var destinationDS = destinationVC.router?.dataStore

        destinationDS?.selectedAlbum = dataStore?.selectedAlbum
        destinationDS?.origin = .albumFeed
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
