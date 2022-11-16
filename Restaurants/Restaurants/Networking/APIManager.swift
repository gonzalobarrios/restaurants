//
//  APIManager.swift
//  Restaurants
//
//  Created by Gonzalo on 11/12/22.
//

import Foundation
import Combine

enum Endpoint {
    case restaurants
    
    var url: String {
        switch self {
        case .restaurants: return "https://alanflament.github.io/TFTest/test.json"
        }
    }
}
class APIManager {
    
    private var subscribers = Set<AnyCancellable>()
    
    let urlString = "https://alanflament.github.io/TFTest/test.json"
    
    func fetchRestaurants(completion: @escaping (Result<[Restaurant], Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                fatalError("Data cannot be found")
            }
            
            do {
                let restaurants = try JSONDecoder().decode(RestaurantData.self, from: data)
                completion(.success(restaurants.restaurants))
            } catch(let error) {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchItems<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { (resultCompletion) in
                switch resultCompletion {
                case .failure(let error):
                    completion(.failure(error))
                case .finished: break
                }
            } , receiveValue: { (result) in
                completion(.success(result))
            }).store(in: &subscribers)
    }
}
