//
//  AlbumViewController.swift
//  Photogram
//
//  Created by Velarde Robles, David on 15/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit

protocol AlbumDisplayLogic: class {
    func displaySomething(viewModel: AlbumModel.Something.ViewModel)
}

class AlbumViewController: UIViewController, AlbumDisplayLogic {
    var interactor: AlbumBusinessLogic?
    var router: (NSObjectProtocol & AlbumRoutingLogic & AlbumDataPassing)?

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
        let interactor = AlbumInteractor()
        let presenter = AlbumPresenter()
        let router = AlbumRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        doSomething()
    }

    // MARK: Do something

    func doSomething() {
        let request = AlbumModel.Something.Request()
        interactor?.doSomething(request: request)
    }

    func displaySomething(viewModel: AlbumModel.Something.ViewModel) {
    }
}
