//
//  AlbumFeedViewController.swift
//  Photogram
//
//  Created by Velarde Robles, David on 15/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit

protocol AlbumFeedDisplayLogic: class {
    func displayAlbums(viewModel: AlbumFeed.LoadAlbums.ViewModel)
    func displayError(viewModel: AlbumFeed.Error.ViewModel)
    func displaySelectedAlbum(viewModel: AlbumFeed.SelectAlbum.ViewModel)
}

class AlbumFeedViewController: UIViewController {
    var interactor: AlbumFeedBusinessLogic?
    var router: (NSObjectProtocol & AlbumFeedRoutingLogic & AlbumFeedDataPassing)?
    let sceneView = BaseTableView()
    var albums = [FeedTableViewCell.ViewModel]()

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
        title = tabBarItem.title
        sceneView.tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.identifier)
        sceneView.tableView.delegate = self
        sceneView.tableView.dataSource = self
        tryLoadAlbums()
    }

    // MARK: Do something

    func tryLoadAlbums() {
        let request = AlbumFeed.LoadAlbums.Request()
        interactor?.loadAlbums(request: request)
    }

    func trySelectPicture(_ index: Int) {
        let request = AlbumFeed.SelectAlbum.Request(selectedIndex: index)
        interactor?.selectAlbum(request: request)
    }
}

extension AlbumFeedViewController: AlbumFeedDisplayLogic {

    func displayAlbums(viewModel: AlbumFeed.LoadAlbums.ViewModel) {
        albums = viewModel.albums
        sceneView.tableView.reloadData()
    }

    func displayError(viewModel: AlbumFeed.Error.ViewModel) {}

    func displaySelectedAlbum(viewModel: AlbumFeed.SelectAlbum.ViewModel) {
        router?.routeToSelectedAlbum()
    }
}

extension AlbumFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return albums.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier, for: indexPath) as? FeedTableViewCell else {
            return UITableViewCell()
        }

        let viewModel = albums[indexPath.row]
        cell.setupView(viewModel)
        
        return cell
    }
}

extension AlbumFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        trySelectPicture(indexPath.row)
    }
}
