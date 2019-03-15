//
//  FeedTableViewCell.swift
//  Photogram
//
//  Created by Velarde Robles, David on 14/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit
import Hero
import PhotogramStore

class FeedTableViewCell: UICollectionViewCell {

    struct ViewModel {
        let title: String?
        let photoURL: String
        let photoId: Int
    }

    private struct ViewTraits {
        static let margin: CGFloat = 10.0
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

        photoImageView.addSubviewForAutolayout(title)
        photoImageView.addSubviewForAutolayout(btnAlbum)
        contentView.addSubviewForAutolayout(photoImageView)
    }

    private func setupConstraints() {

        NSLayoutConstraint.activate([
            btnAlbum.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: -ViewTraits.margin),
            btnAlbum.topAnchor.constraint(equalTo: photoImageView.topAnchor, constant: ViewTraits.margin),

            title.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor, constant: ViewTraits.margin),
            title.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: -ViewTraits.margin),
            title.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: -ViewTraits.margin),

            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)])
    }

    func setupView(_ viewModel: ViewModel) {

        title.text = viewModel.title
        photoImageView.hero.id = "photo_\(viewModel.photoId)"

        if let photo = StorageHelper.getPhoto(fromPhotoId: viewModel.photoId, isThumb: true) {

            photoImageView.image = photo
        } else {

            loadingPhotoId = viewModel.photoId

            StorageHelper.savePhoto(fromURL: viewModel.photoURL, forPhotoId: viewModel.photoId, isThumb: true) { [weak self] photo, photoId in

                if photoId == self?.loadingPhotoId {

                    self?.photoImageView.image = photo
                }
            }
        }
    }

}
