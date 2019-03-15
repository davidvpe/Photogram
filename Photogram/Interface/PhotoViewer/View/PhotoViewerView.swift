//
//  PhotoViewerView.swift
//  Photogram
//
//  Created by Velarde Robles, David on 15/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit

protocol PhotoViewerViewDelegate: class {
    func shouldUpdateNavigationBar(isHidden: Bool)
}

class PhotoViewerView: UIView {

    enum ViewState {
        case initial
        case fullScreen
    }

    let scrollView: ImageScrollView
    var currentState: ViewState = .initial
    weak var delegate: PhotoViewerViewDelegate?
    lazy var tapGR: UITapGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: #selector(didTapOnView))
    }()

    override init(frame: CGRect) {

        scrollView = ImageScrollView()

        super.init(frame: frame)
        backgroundColor = .white

        setupComponents()
        setupConstraints()
    }

    func setupComponents() {
        addSubviewForAutolayout(scrollView)
        scrollView.addGestureRecognizer(tapGR)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     scrollView.topAnchor.constraint(equalTo: topAnchor),
                                     scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView(withImage image: UIImage) {
        scrollView.image = image
        scrollView.setZoomScale()
    }

    @objc func didTapOnView() {
        switch currentState {
        case .initial:
            transformTo(.fullScreen)
        case .fullScreen:
            transformTo(.initial)
        }
    }

    private func transformTo(_ newState: ViewState) {
        currentState = newState
        var newBGColor: UIColor?
        switch newState {
        case .fullScreen:
            delegate?.shouldUpdateNavigationBar(isHidden: true)
            newBGColor = .black
        case .initial:
            delegate?.shouldUpdateNavigationBar(isHidden: false)
            newBGColor = .white
        }
        UIView.animate(withDuration: 0.15) {
            self.backgroundColor = newBGColor
        }
    }
}
