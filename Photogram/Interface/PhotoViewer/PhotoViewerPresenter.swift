//
//  PhotoViewerPresenter.swift
//  Photogram
//
//  Created by Velarde Robles, David on 15/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit

protocol PhotoViewerPresentationLogic {
    func presentSomething(response: PhotoViewer.LoadPicture.Response)
}

class PhotoViewerPresenter: PhotoViewerPresentationLogic {
    weak var viewController: PhotoViewerDisplayLogic?

    // MARK: Do something

    func presentSomething(response: PhotoViewer.LoadPicture.Response) {
        let viewModel = PhotoViewer.LoadPicture.ViewModel(photo: response.photo, photoId: response.photoId)
        viewController?.displayPhoto(viewModel: viewModel)
    }
}
