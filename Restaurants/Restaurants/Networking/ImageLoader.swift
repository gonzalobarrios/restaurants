//
//  ImageLoader.swift
//  Restaurants
//
//  Created by Gonzalo on 11/15/22.
//

import Foundation
import UIKit

class ImageLoader {
    static var shared = ImageLoader()
    private var cache = [URL: UIImage]()
    private var runningRequests = [UUID: URLSessionDataTask]()
    
    func getImageData(with urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {

        guard let url = URL(string: urlString) else {
            return nil
        }

        if let image = cache[url] {
            completion(.success(image))
            return nil
        }

        let uuid = UUID()
        let task = URLSession.shared.dataTask(with: url) { data, response , error in
            defer {self.runningRequests.removeValue(forKey: uuid) }

            if let data = data, let image = UIImage(data: data) {
                self.cache[url] = image
                completion(.success(image))
                return
            }

            guard let error = error else {
              return
            }

            guard (error as NSError).code == NSURLErrorCancelled else {
              completion(.failure(error))
              return
            }
          }
          task.resume()

        runningRequests[uuid] = task
        return uuid
    }
    
    func cancelLoad(_ uuid: UUID) {
      runningRequests[uuid]?.cancel()
      runningRequests.removeValue(forKey: uuid)
    }
}


