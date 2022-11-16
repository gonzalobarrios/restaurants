//
//  RestaurantsTests.swift
//  RestaurantsTests
//
//  Created by Gonzalo on 11/12/22.
//

import XCTest
import Combine
@testable import Restaurants

class RestaurantsTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!
    let restaurant = Restaurant(uuid: "12343", name: "gonzalo", ratings: Ratings(tripadvisor: Rating(ratingValue: 5.0, reviewCount: 4.7), thefork: Rating(ratingValue: 5.0, reviewCount: 4.7)), address: Address(street: "1234 Road", postalCode: "11800", locality: "Montevideo", country: "Uruguay"), mainPhoto: MainPhoto(source: nil, s612x344: nil, s480x270: nil, s240x135: nil, s664x374: nil, s1350x759: nil, s160x120: nil, s80x60: nil, s92x92: nil, s184x184: nil))
    
    override class func setUp() {
        super.setUp()
    }

    
    func testsuccess(){
        let viewModel = StubHomeViewModel(apiManager: APIManager(), endpoint: .restaurants)
        let spy = ValueSpy(viewModel.valuePublisher)
        let expectation = self.expectation(description: "Restaurants list")

        viewModel.fetchRestaurants()
        
        let _ = viewModel.valuePublisher.sink(receiveCompletion: { completion in
            print(completion)
        }, receiveValue: { result in
            XCTAssertEqual(2, result.count)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 5.0)
    }
}

class ValueSpy {
    private(set) var values = [Restaurant]()
    private(set) var error: Error?
    private var cancellable: AnyCancellable!
    
    init(_ publisher: AnyPublisher<[Restaurant], Error>) {
        cancellable = publisher.sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                self.error = error
            case .finished: break
            }
        }, receiveValue: { [weak self] result in
            self?.values.append(contentsOf: result)
        })
    }
}


class StubApiManager: APIManager {
    override func fetchItems<T>(url: URL, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        let restaurants: RestaurantData = RestaurantData(restaurants: [Restaurant(uuid: "12343", name: "gonzalo", ratings: Ratings(tripadvisor: Rating(ratingValue: 5.0, reviewCount: 4.7), thefork: Rating(ratingValue: 5.0, reviewCount: 4.7)), address: Address(street: "1234 Road", postalCode: "11800", locality: "Montevideo", country: "Uruguay"), mainPhoto: MainPhoto(source: nil, s612x344: nil, s480x270: nil, s240x135: nil, s664x374: nil, s1350x759: nil, s160x120: nil, s80x60: nil, s92x92: nil, s184x184: nil)), Restaurant(uuid: "12343", name: "gonzalo", ratings: Ratings(tripadvisor: Rating(ratingValue: 5.0, reviewCount: 4.7), thefork: Rating(ratingValue: 5.0, reviewCount: 4.7)), address: Address(street: "1234 Road", postalCode: "11800", locality: "Montevideo", country: "Uruguay"), mainPhoto: MainPhoto(source: nil, s612x344: nil, s480x270: nil, s240x135: nil, s664x374: nil, s1350x759: nil, s160x120: nil, s80x60: nil, s92x92: nil, s184x184: nil))])
        completion(.success(restaurants as! T))
    }
}

class StubHomeViewModel: HomeViewModel {
    let url: String = Endpoint.restaurants.url
    override func fetchRestaurants() {
        StubApiManager().fetchItems(url: URL(string: url)!) { (result: Result<RestaurantData, Error>) in
            switch result {
            case .success(let restaurantsData):
                self.restaurantSubject.send(restaurantsData.restaurants)
            case .failure(let error):
                self.restaurantSubject.send(completion: .failure(error))
            }
        }
    }
}
