//
//  NetworkOperation.swift
//  PhotoStore
//
//  Created by Velarde Robles, David on 13/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit

public class NetworkOperation: ConcurrentOperation {
	
	var task: URLSessionDataTask?
	
	var urlString: URLRepresentable
	var params: [Parameter]
	var httpMethod: HTTPMethod
	var encoding: EncodingType
	var finishedBlock: ((RequestResult) -> Void)

	init(_ urlString: URLRepresentable, params: [Parameter], httpMethod: HTTPMethod = .get, encoding: EncodingType = .url, finishedBlock: @escaping (RequestResult) -> Void) {
		
		self.urlString = urlString
		self.params = params
		self.httpMethod = httpMethod
		self.encoding = encoding
		self.finishedBlock = finishedBlock
	
		task = nil
		
	}
	
	override public func start() {
		
		if !isCancelled && isReady {
			
			super.start()
			
            let request = DavidFire.shared.request(urlString,
                                                   params: params,
                                                   httpMethod: httpMethod,
                                                   encoding: encoding,
                                                   completionBlock: { (result) in
                                                    self.finish()
                                                    self.finishedBlock(result)
            })
            task = request
			task?.resume()
			
		}
	}
	
	override public func cancel() {
		task?.cancel()
		super.cancel()
	}
}
