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

class FeedTableViewCell: UITableViewCell {

    struct ViewModel {
        let title: String?
        let albumId: Int
    }

    private struct ViewTraits {
        static let margin: CGFloat = 10.0
        static let imageWidth: CGFloat = 25.0
    }

    static let identifier: String = "feedTableViewCell"

    let iconImageView: UIImageView
    let title: UILabel
    var loadingPhotoId: Int = -1

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        iconImageView = UIImageView(frame: .zero)
        title = UILabel(frame: .zero)

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

        iconImageView.contentMode = .scaleAspectFit
        iconImageView.image = UIImage(named: "albums")

        title.numberOfLines = 0

        contentView.addSubviewForAutolayout(title)
        contentView.addSubviewForAutolayout(iconImageView)
    }

    private func setupConstraints() {

        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ViewTraits.margin),
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ViewTraits.margin),
            iconImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -ViewTraits.margin),
            iconImageView.widthAnchor.constraint(equalToConstant: ViewTraits.imageWidth),

            title.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: ViewTraits.margin),
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ViewTraits.margin),
            title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -ViewTraits.margin),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ViewTraits.margin)])
    }

    func setupView(_ viewModel: ViewModel) {

        title.text = viewModel.title
        iconImageView.hero.id = "photo_\(viewModel.albumId)"

    }

}
