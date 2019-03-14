//
//  UIView.swift
//  Photogram
//
//  Created by Velarde Robles, David on 14/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviewForAutolayout(_ subview: UIView) {

        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
    }
}
