//
//  ImageScrollView.swift
//  Photogram
//
//  Created by Velarde Robles, David on 15/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit

class ImageScrollView: UIScrollView {

    let imageView = UIImageView()
    private var imageViewBottomConstraint = NSLayoutConstraint()
    private var imageViewLeadingConstraint = NSLayoutConstraint()
    private var imageViewTopConstraint = NSLayoutConstraint()
    private var imageViewTrailingConstraint = NSLayoutConstraint()

    var image: UIImage? {
        didSet {
            imageView.image = image
            imageView.sizeToFit()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviewForAutolayout(imageView)

        imageViewLeadingConstraint = imageView.leadingAnchor.constraint(equalTo: leadingAnchor)
        imageViewTrailingConstraint = imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        imageViewTopConstraint = imageView.topAnchor.constraint(equalTo: topAnchor)
        imageViewBottomConstraint = imageView.bottomAnchor.constraint(equalTo: bottomAnchor)

        NSLayoutConstraint.activate([imageViewLeadingConstraint,
                                     imageViewTrailingConstraint,
                                     imageViewTopConstraint,
                                     imageViewBottomConstraint])

        contentInsetAdjustmentBehavior = .never // Adjust content according to safe area if necessary
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        alwaysBounceHorizontal = true
        alwaysBounceVertical = true
        delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helper methods

    func setZoomScale() {
        let widthScale = frame.size.width / imageView.bounds.width
        let heightScale = frame.size.height / imageView.bounds.height
        let minScale = min(widthScale, heightScale)
        minimumZoomScale = minScale
        zoomScale = minScale
        layoutIfNeeded()
    }

}

extension ImageScrollView: UIScrollViewDelegate {

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let yOffset = max(0, (bounds.size.height - imageView.frame.height) / 2)
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset

        let xOffset = max(0, (bounds.size.width - imageView.frame.width) / 2)
        imageViewLeadingConstraint.constant = xOffset
        imageViewTrailingConstraint.constant = xOffset

        layoutIfNeeded()
    }

}
