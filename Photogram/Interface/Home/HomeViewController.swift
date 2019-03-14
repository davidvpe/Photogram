//
//  HomeViewController.swift
//  Photogram
//
//  Created by Velarde Robles, David on 13/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit

protocol HomeDisplayLogic: class {
    func displayPhotos(viewModel: Home.LoadPictures.ViewModel)
    func displayError(viewModel: Home.Error.ViewModel)
}

class HomeViewController: UIViewController {
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    let sceneView = BaseCollectionView()
    var arrayPhotos = [FeedTableViewCell.ViewModel]()
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
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
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

        sceneView.collectionView.dataSource = self
        sceneView.collectionView.delegate = self
        sceneView.collectionView.register(FeedTableViewCell.self, forCellWithReuseIdentifier: FeedTableViewCell.identifier)
        tryLoadPictures()
    }

    // MARK: Do something

    //@IBOutlet weak var nameTextField: UITextField!

    func tryLoadPictures() {
        let request = Home.LoadPictures.Request()
        interactor?.loadPictures(request: request)
    }
}

extension HomeViewController: HomeDisplayLogic {
    func displayError(viewModel: Home.Error.ViewModel) {
        print(viewModel.description)
    }

    func displayPhotos(viewModel: Home.LoadPictures.ViewModel) {
        arrayPhotos = viewModel.photos
        sceneView.collectionView.reloadData()
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayPhotos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let feedCell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedTableViewCell.identifier, for: indexPath) as? FeedTableViewCell else {
            return UICollectionViewCell()
        }
        let viewModel = arrayPhotos[indexPath.row]
        feedCell.setupView(viewModel)
        return feedCell
    }
}

extension HomeViewController: UICollectionViewDelegate {

}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = UIScreen.main.bounds.width / 2
        return CGSize(width: size, height: size)
    }
}
