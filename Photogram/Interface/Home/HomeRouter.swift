//
//  HomeRouter.swift
//  Photogram
//
//  Created by Velarde Robles, David on 13/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit

@objc protocol HomeRoutingLogic {
    func routeToSelectedPhoto()
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing {
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
    
    // MARK: Routing

    func routeToSelectedPhoto() {
        let destinationVC = PhotoViewerViewController()
        var destinationDS = destinationVC.router?.dataStore

        destinationDS?.selectedPhoto = dataStore?.selectedPhoto
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
