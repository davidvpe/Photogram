//
//  PhotoViewerRouter.swift
//  Photogram
//
//  Created by Velarde Robles, David on 15/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit

@objc protocol PhotoViewerRoutingLogic { }

protocol PhotoViewerDataPassing {
  var dataStore: PhotoViewerDataStore? { get }
}

class PhotoViewerRouter: NSObject, PhotoViewerRoutingLogic, PhotoViewerDataPassing {
  weak var viewController: PhotoViewerViewController?
  var dataStore: PhotoViewerDataStore?
  
  // MARK: Routing
  
}
