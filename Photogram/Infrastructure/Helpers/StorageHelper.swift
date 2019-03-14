//
//  StorageHelper.swift
//  Photogram
//
//  Created by Velarde Robles, David on 14/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import Foundation
import PhotogramStore

typealias PhotoDownloadResponse = (UIImage, Int) -> ()

class StorageHelper {

    static func savePhoto(fromURL photoURL: String, forPhotoId photoId: Int, completionHandler: @escaping PhotoDownloadResponse) {

        AssetsStore.shared.downloadImage(withURL: photoURL) { (image) in

            guard let image = image, let data = image.pngData() else {
                return
            }

            let fileName = "\(photoId).png"

            guard let directory = try? FileManager.default.url(for: .documentDirectory,
                                                               in: .userDomainMask,
                                                               appropriateFor: nil,
                                                               create: false) as NSURL,
                let path = directory.appendingPathComponent(fileName) else {

                return
            }

            try? data.write(to: path)

            completionHandler(image, photoId)
        }
    }

    static func getPhoto(fromPhotoId photoId: Int) -> UIImage? {

        let fileName = "\(photoId).png"

        if let dir = try? FileManager.default.url(for: .documentDirectory,
                                                  in: .userDomainMask,
                                                  appropriateFor: nil,
                                                  create: false) {

            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(fileName).path)
        }
        return nil
    }
}
