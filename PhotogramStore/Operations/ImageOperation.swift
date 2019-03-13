//
//  NetworkOperation.swift
//  PhotoStore
//
//  Created by Velarde Robles, David on 13/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit

public class ImageOperation: ConcurrentOperation {

    var task: URLSessionDataTask?

	var urlString: URLRepresentable
	var httpMethod: HTTPMethod
	var encoding: EncodingType
	var finishedBlock: ((UIImage?) -> Void)

    init(_ urlString: URLRepresentable, httpMethod: HTTPMethod = .get, encoding: EncodingType = .url, finishedBlock: @escaping (UIImage?) -> Void) {
		
		self.urlString = urlString
		self.httpMethod = httpMethod
		self.encoding = encoding
		self.finishedBlock = finishedBlock
	
		task = nil
		
	}
	
	override public func start() {
		
		if !isCancelled && isReady {
			
			super.start()
			
            let request = DavidFire.shared.downloadImage(urlString) { result in
				self.finish()
				self.finishedBlock(result)
			}

			task = request
			task?.resume()
		}
	}

	override public func cancel() {

        task?.cancel()
		super.cancel()
	}
}
