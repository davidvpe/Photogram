//
//  HomeModels.swift
//  Photogram
//
//  Created by Velarde Robles, David on 13/03/2019.`
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit

enum Home {
    // MARK: Use cases

    enum InitialConfig {

        struct Request {}

        struct Response {
            let selectedAlbum: AlbumModel?
        }

        struct ViewModel {
            let title: String
            let shouldShowTabBar: Bool
        }
    }

    enum LoadPhotos {

        struct Request {}

        struct Response {
            let photos: [PhotoModel]
        }

        struct ViewModel {
            let photos: [PhotoCollectionViewCell.ViewModel]
        }
    }

    enum SelectPhoto {
        struct Request {
            let selectedIndex: Int
        }
        struct Response { }
        struct ViewModel { }
    }

    enum Error {

        enum ErrorType {
            case parsingError
            case networkError
            case missingAlbum
        }

        struct Response {
            let errorType: ErrorType
            let description: String?
        }

        struct ViewModel {
            let description: String
        }
    }
}
