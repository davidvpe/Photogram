//
//  PhotoViewerViewController.swift
//  Photogram
//
//  Created by Velarde Robles, David on 15/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit
import Hero

protocol PhotoViewerDisplayLogic: class {
    func displayPhoto(viewModel: PhotoViewer.LoadPicture.ViewModel)
}

class PhotoViewerViewController: UIViewController, PhotoViewerDisplayLogic {
    var interactor: PhotoViewerBusinessLogic?
    var router: (NSObjectProtocol & PhotoViewerRoutingLogic & PhotoViewerDataPassing)?
    let sceneView = PhotoViewerView()
    var imageDisplayed: UIImage?

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = PhotoViewerInteractor()
        let presenter = PhotoViewerPresenter()
        let router = PhotoViewerRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: View lifecycle

    override func loadView() {
        view = sceneView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tryLoadPicture()
        sceneView.delegate = self
    }

    override func viewDidLayoutSubviews() {
        if let imageDisplayed = imageDisplayed {
            sceneView.setupView(withImage: imageDisplayed)
        }
        super.viewDidLayoutSubviews()
    }

    // MARK: Do something

    func tryLoadPicture() {
        let request = PhotoViewer.LoadPicture.Request()
        interactor?.loadPicture(request: request)
    }

    func displayPhoto(viewModel: PhotoViewer.LoadPicture.ViewModel) {
        imageDisplayed = viewModel.photo
        sceneView.scrollView.imageView.hero.id = "photo_\(viewModel.photoId)"
    }
}

extension PhotoViewerViewController: PhotoViewerViewDelegate {
    func shouldUpdateNavigationBar(isHidden: Bool) {
        navigationController?.setNavigationBarHidden(isHidden, animated: true)
    }
}
