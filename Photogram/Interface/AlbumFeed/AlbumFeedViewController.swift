//
//  AlbumFeedViewController.swift
//  Photogram
//
//  Created by Velarde Robles, David on 15/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit

protocol AlbumFeedDisplayLogic: class {
    func displaySomething(viewModel: AlbumFeed.Something.ViewModel)
}

class AlbumFeedViewController: UIViewController, AlbumFeedDisplayLogic {
    var interactor: AlbumFeedBusinessLogic?
    var router: (NSObjectProtocol & AlbumFeedRoutingLogic & AlbumFeedDataPassing)?
    let sceneView = BaseTableView()

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
        let interactor = AlbumFeedInteractor()
        let presenter = AlbumFeedPresenter()
        let router = AlbumFeedRouter()
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
        doSomething()
    }

    // MARK: Do something

    func doSomething() {
        let request = AlbumFeed.Something.Request()
        interactor?.doSomething(request: request)
    }

    func displaySomething(viewModel: AlbumFeed.Something.ViewModel) {
    }
}
