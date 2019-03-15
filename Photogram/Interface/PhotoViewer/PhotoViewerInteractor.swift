//
//  PhotoViewerInteractor.swift
//  Photogram
//
//  Created by Velarde Robles, David on 15/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit

protocol PhotoViewerBusinessLogic {
    func loadPicture(request: PhotoViewer.LoadPicture.Request)
}

protocol PhotoViewerDataStore {
    var selectedPhoto: Photo? { get set }
}

class PhotoViewerInteractor: PhotoViewerBusinessLogic, PhotoViewerDataStore {
    var presenter: PhotoViewerPresentationLogic?
    var worker = PhotoViewerWorker()
    var selectedPhoto: Photo?

    // MARK: Do something

    func loadPicture(request: PhotoViewer.LoadPicture.Request) {
        guard let photo = selectedPhoto else {
            return
        }

        worker.getPhoto(withPhotoId: photo.id, andPhotoUrl: photo.url, completionHandler: { [weak self] image in
            let response = PhotoViewer.LoadPicture.Response(photo: image, photoId: photo.id)
            self?.presenter?.presentSomething(response: response)
        })
    }
}
