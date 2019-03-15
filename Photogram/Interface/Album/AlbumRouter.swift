//
//  AlbumRouter.swift
//  Photogram
//
//  Created by Velarde Robles, David on 15/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit

@objc protocol AlbumRoutingLogic { }

protocol AlbumDataPassing { }

class AlbumRouter: NSObject, AlbumRoutingLogic, AlbumDataPassing {
    weak var viewController: AlbumViewController?
    var dataStore: AlbumDataStore?
    
    // MARK: Routing
    
}
