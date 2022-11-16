//
//  HomeViewModel.swift
//  Restaurants
//
//  Created by Gonzalo on 11/15/22.
//

import Foundation
import Combine

class HomeViewModel {
    
    private let apiManager: APIManager
    private let endpoint: Endpoint
    
    var restaurantSubject = CurrentValueSubject<[Restaurant], Error>([])
    var valuePublisher: AnyPublisher<[Restaurant], Error> {
        restaurantSubject.map { value in
            value
        }.eraseToAnyPublisher()
    }
    
    init(apiManager: APIManager, endpoint: Endpoint) {
        self.apiManager = apiManager
        self.endpoint = endpoint
    }
    
    func fetchRestaurants() {
        let url = URL(string: endpoint.url)!
        
        apiManager.fetchItems(url: url) { [weak self] (result: Result<RestaurantData, Error>) in
            switch result {
            case .success(let restaurantsData):
                self?.restaurantSubject.send(restaurantsData.restaurants)
            case .failure(let error):
                self?.restaurantSubject.send(completion: .failure(error))
            }
        }
    }
}
