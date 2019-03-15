//
//  PhotoViewerWorker.swift
//  Photogram
//
//  Created by Velarde Robles, David on 15/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit
import PhotogramStore

class PhotoViewerWorker {
    func getPhoto(withPhotoId photoId: Int, andPhotoUrl photoUrl: String, completionHandler: @escaping (UIImage) -> ()) {
        if let photo = StorageHelper.getPhoto(fromPhotoId: photoId, isThumb: false) {
            completionHandler(photo)
        } else {
            StorageHelper.savePhoto(fromURL: photoUrl,
                                    forPhotoId: photoId,
                                    isThumb: false,
                                    completionHandler: { image, _ in
                                        completionHandler(image)
            })
        }
    }
}
