//
//  AlbumFeedRouter.swift
//  Photogram
//
//  Created by Velarde Robles, David on 15/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit

@objc protocol AlbumFeedRoutingLogic { }

protocol AlbumFeedDataPassing {
    var dataStore: AlbumFeedDataStore? { get }
}

class AlbumFeedRouter: NSObject, AlbumFeedRoutingLogic, AlbumFeedDataPassing {
    weak var viewController: AlbumFeedViewController?
    var dataStore: AlbumFeedDataStore?

    // MARK: Routing

}
