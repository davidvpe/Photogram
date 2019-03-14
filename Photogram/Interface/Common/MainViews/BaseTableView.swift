//
//  StandardTableView.swift
//  Photogram
//
//  Created by Velarde Robles, David on 14/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit

class BaseTableView: UIView {

    private struct ViewTraits {
        static let estimatedRowHeight: CGFloat = 80.0
    }

    let tableView: UITableView

    override init(frame: CGRect) {

        tableView = UITableView(frame: .zero, style: .plain)

        super.init(frame: frame)

        setupComponents()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupComponents() {
        backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = ViewTraits.estimatedRowHeight
        addSubviewForAutolayout(tableView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     tableView.topAnchor.constraint(equalTo: topAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
}
