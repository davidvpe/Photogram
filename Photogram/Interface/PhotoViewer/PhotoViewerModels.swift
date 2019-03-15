//
//  PhotoViewerModels.swift
//  Photogram
//
//  Created by Velarde Robles, David on 15/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit

enum PhotoViewer {
    // MARK: Use cases
    
    enum LoadPicture {
        struct Request {
        }
        struct Response {
            let photo: UIImage
            let photoId: Int
        }
        struct ViewModel {
            let photo: UIImage
            let photoId: Int
        }
    }
}
