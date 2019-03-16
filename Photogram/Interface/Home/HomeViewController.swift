//
//  HomeViewController.swift
//  Photogram
//
//  Created by Velarde Robles, David on 13/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit

protocol HomeDisplayLogic: class {
    func displayPhotos(viewModel: Home.LoadPhotos.ViewModel)
    func displayError(viewModel: Home.Error.ViewModel)
    func displaySelectedPhoto(viewModel: Home.SelectPhoto.ViewModel)
}

class HomeViewController: UIViewController {
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    let sceneView = BaseCollectionView()
    var arrayPhotos = [PhotoCollectionViewCell.ViewModel]()
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
        title = tabBarItem.title
        sceneView.collectionView.dataSource = self
        sceneView.collectionView.delegate = self
        sceneView.collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        tryLoadPictures()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.hideTabBarAnimated(hide: false)
    }

    // MARK: Do something

    func tryLoadPictures() {
        let request = Home.LoadPhotos.Request()
        interactor?.loadPictures(request: request)
    }

    func trySelectPicture(_ index: Int) {
        let request = Home.SelectPhoto.Request(selectedIndex: index)
        interactor?.selectPicture(request: request)
    }
}

extension HomeViewController: HomeDisplayLogic {
    func displayError(viewModel: Home.Error.ViewModel) {
        print(viewModel.description)
    }

    func displayPhotos(viewModel: Home.LoadPhotos.ViewModel) {
        arrayPhotos = viewModel.photos
        sceneView.collectionView.reloadData()
    }

    func displaySelectedPhoto(viewModel: Home.SelectPhoto.ViewModel) {
        tabBarController?.hideTabBarAnimated(hide: true)
        router?.routeToSelectedPhoto()
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayPhotos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        let viewModel = arrayPhotos[indexPath.row]
        photoCell.setupView(viewModel)
        return photoCell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        trySelectPicture(indexPath.item)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = UIScreen.main.bounds.width / 2
        return CGSize(width: size, height: size)
    }
}
