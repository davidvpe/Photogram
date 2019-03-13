//
//  Store.swift
//  PhotogramStore
//
//  Created by Velarde Robles, David on 13/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit

public enum NetworkDataResult {

    case success(response: Data)
    case failure(description: String)
}

public typealias NetworkManagerDataHandler = (_ responseData: NetworkDataResult) -> ()

public class Store {

    let requestQueue = OperationQueue()

    internal func enqueueOperationWithDependancies(operation: Operation) {
        for dependancy in operation.dependencies {
            enqueueOperationWithDependancies(operation: dependancy)
        }
        requestQueue.addOperation(operation)
    }
}

public final class AssetsStore: Store {
    public static let shared = AssetsStore()

    public func downloadImage(withURL url: String, completion: @escaping (UIImage?) -> Void) -> ImageOperation {

        let operation = ImageOperation(url) { (image) in
            completion(image)
        }

        enqueueOperationWithDependancies(operation: operation)

        return operation
    }

}

public final class PhotogramStore: Store {

    let baseURL: String = "https://jsonplaceholder.typicode.com/"

	public static let shared = PhotogramStore()
}
