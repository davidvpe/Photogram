//
//  FeedTableViewCell.swift
//  Photogram
//
//  Created by Velarde Robles, David on 14/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit
import PhotogramStore

class FeedTableViewCell: UITableViewCell {

    struct ViewModel {
        let title: String?
        let photoURL: String
        let photoId: Int
    }

    private struct ViewTraits {
        static let mainSpacing: CGFloat = 5.0
    }

    static let identifier: String = "feedTableViewCell"

    let btnAlbum: UIButton
    let photoImageView: UIImageView
    let title: UILabel
    let stackView: UIStackView
    var loadingPhotoId: Int = -1

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        btnAlbum = UIButton(type: .custom)
        photoImageView = UIImageView(frame: .zero)
        title = UILabel(frame: .zero)
        stackView = UIStackView(frame: .zero)

        super.init(style: style, reuseIdentifier: reuseIdentifier)

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

        photoImageView.contentMode = .scaleToFill

        title.numberOfLines = 0

        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = ViewTraits.mainSpacing

        photoImageView.addSubviewForAutolayout(btnAlbum)
        stackView.addArrangedSubview(photoImageView)
        stackView.addArrangedSubview(title)
        contentView.addSubviewForAutolayout(stackView)
    }

    private func setupConstraints() {

        NSLayoutConstraint.activate([stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                                     stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                                     stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
                                     stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)])
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
