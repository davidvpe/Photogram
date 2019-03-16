//
//  UserModel.swift
//  Photogram
//
//  Created by Velarde Robles, David on 16/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import Foundation

struct UserModel {
    let id: Int
    let name: String
    let username: String
    let email: String
    let adress: UserAddress
    let phone: String
    let website: String
    let company: UserCompany
}

struct UserAddress {

    struct Geocode {
        let lat: String
        let lng: String
    }

    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geocode
}

struct UserCompany {
    let name: String
    let catchPhrase: String
    let bs: String
}
