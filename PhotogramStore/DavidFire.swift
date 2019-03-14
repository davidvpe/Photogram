//
//  DavidFire.swift
//  PhotogramStore
//
//  Created by Velarde Robles, David on 13/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit

public struct Parameter {
	private let key: String
	private let value: String
	
	init(_ key: String, _ value: Any) {
		self.key = key
		self.value = "\(value)"
	}
	
	func getValue() -> String {
		return value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
	}
	func getKey() -> String {
		return key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
	}
}

internal enum RequestResult {
	case error(description: String?)
	case data(value: Data?)
}

public enum HTTPMethod: String {
	case get
	
	var string: String {
		return self.rawValue.uppercased()
	}
}

public enum EncodingType {
	case json
	case url
}

internal class DavidFire {
	
	static let shared = DavidFire()
	private let session: URLSession?
	private let timeout: TimeInterval
	private init() {
		session = URLSession.shared
		timeout = 60
	}
	
	let requestQueue = OperationQueue()

    func downloadImage(_ imageURL: String, completion: @escaping (UIImage?) -> Void) -> URLSessionDataTask? {
        if let url = URL(string: imageURL) {
            let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: timeout)
            return self.session?.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    if let data = data {
                        let image = UIImage(data: data)
                        completion(image)
                    } else {
                        completion(nil)
                        return
                    }
                }
            }
        }

        return nil
    }

	func request(_ urlString: URLRepresentable,
                 params: [Parameter],
                 httpMethod: HTTPMethod = .get,
                 encoding: EncodingType = .url,
                 completionBlock: @escaping (RequestResult) -> Void) -> URLSessionDataTask? {

		if let url = URL(string: urlString) {
            guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
                return nil
            }
            urlComponents.queryItems = [URLQueryItem]()
            for param in params {
                let item = URLQueryItem(name: param.getKey(), value: param.getValue())
                urlComponents.queryItems?.append(item)
            }

            guard let urlWithParams = urlComponents.url else {
                return nil
            }

            var request = URLRequest(url: urlWithParams, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: timeout)
			request.httpMethod = httpMethod.string
			request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

			return self.session?.dataTask(with: request, completionHandler: { (data, response, error) in
                DispatchQueue.main.async {
                    if error != nil {
                        completionBlock(.error(description: error?.localizedDescription))
                    } else {
                        completionBlock(.data(value: data))
                    }
                }
			})
		}
		return nil
	}
	
}
