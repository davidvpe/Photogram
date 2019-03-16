//
//  AlbumFeedModels.swift
//  Photogram
//
//  Created by Velarde Robles, David on 15/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit

enum AlbumFeed {
    // MARK: Use cases

    enum LoadAlbums {
        struct Request {
        }
        struct Response {
            let albums: [AlbumModel]
        }
        struct ViewModel {
            let albums: [FeedTableViewCell.ViewModel]
        }
    }

    enum SelectAlbum {
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
