//
//  HomeModels.swift
//  Photogram
//
//  Created by Velarde Robles, David on 13/03/2019.
//  Copyright (c) 2019 David Velarde. All rights reserved.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit

enum Home {
    // MARK: Use cases
    
    enum LoadPictures {
        struct Request {
        }
        struct Response {
            let photos: [Photo]
        }
        struct ViewModel {
            let photos: [FeedTableViewCell.ViewModel]
        }
    }

    enum Error {

        enum ErrorType {
            case parsingError
            case emtpyArray
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
