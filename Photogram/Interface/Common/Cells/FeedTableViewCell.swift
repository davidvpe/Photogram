//
//  FeedTableViewCell.swift
//  Photogram
//
//  Created by Velarde Robles, David on 14/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit
import PhotogramStore

class FeedTableViewCell: UICollectionViewCell {

    struct ViewModel {
        let title: String?
        let photoURL: String
        let photoId: Int
    }

    static let identifier: String = "feedTableViewCell"

    let btnAlbum: UIButton
    let photoImageView: UIImageView
    let title: UILabel
    var loadingPhotoId: Int = -1

    override init(frame: CGRect) {
        btnAlbum = UIButton(type: .custom)
        photoImageView = UIImageView(frame: .zero)
        title = UILabel(frame: .zero)

        super.init(frame: frame)

        setupComponents()
        setupConstraints()
    }

    override func prepareForReuse() {
        loadingPhotoId = -1
        super.prepareForReuse()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupComponents() {

        btnAlbum.setImage(UIImage(named: "icoAlbum"), for: .normal)

        photoImageView.contentMode = .scaleAspectFit

        title.numberOfLines = 0

        contentView.addSubviewForAutolayout(photoImageView)
    }

    private func setupConstraints() {

        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                                     photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                                     photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                                     photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)])
    }

    func setupView(_ viewModel: ViewModel) {
        title.text = viewModel.title
        if let photo = StorageHelper.getPhoto(fromPhotoId: viewModel.photoId) {
            photoImageView.image = photo
        } else {
            loadingPhotoId = viewModel.photoId
            StorageHelper.savePhoto(fromURL: viewModel.photoURL, forPhotoId: viewModel.photoId) { photo, photoId in
                if photoId == self.loadingPhotoId {
                    self.photoImageView.image = photo
                }
            }
        }
    }

}
