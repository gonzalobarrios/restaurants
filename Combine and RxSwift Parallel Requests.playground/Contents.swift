import Combine
// Parallel

func getRestaurants(with urls: [String]) {
    ids.map{ getRestaurant(with: $0).eraseToAnyPublisher() }
        .publisher
        .flatMap { $0 }
        .collect()
        .sink { restaurant in
            print(restaurant.sorted(by: { $0.id < $1.id }))
        }
}

func getRestaurant(with url: String) -> AnyPublisher<Restaurant, Never> {
    // Request code goes here
}

import RxSwift

func getRestaurants(with urls: [String]) {
    Observable.zip(urls.map{ getRestaurant(with: $0) })
        .subscribe { restaurants in
            print(restaurants)
        }
        .disposed(by: bag)
}

func getRestaurant(with url: String) -> Observable<Restaurant> {
    // Request code goes here
}


//Sequential

import Combine


func loadRestaurantDetails() -> AnyPublisher<RestaurantDetails, Error> {
    getRestaurant(with: "someURL").flatMap { restaurant in
        getRestaurantDetails(with: restaurant)
    }
}

func getRestaurant(with url: String) -> AnyPublisher<Restaurant, Never> {
    let url = URL(string: "https://google.com")
    return URLSession.shared.dataTask(with: url)
        .tryMap { result in
            return result
        }
        .decode(type: Restaurant.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
}

func getRestaurantDetails(with restaurant: Restaurant) -> AnyPublisher<RestaurantDetails, Never> {
    let url = URL(string: "https://google.com/\(restaurant.id)/details")
    return URLSession.shared.dataTask(with: url)
        .tryMap { result in
            return result
        }
        .decode(type: RestaurantDetails.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
}


import RxSwift

func getRestaurants(with urls: [String]) {
    Observable.zip(urls.flatMap { getRestaurant(with: $0) })
        .subscribe { restaurants in
            print(restaurants)
        }
        .disposed(by: bag)
}

func getRestaurant(with url: String) -> Observable<Restaurant> {
    // Request code goes here
}




class Person {
    let name: String
    let surname: String
    
    init(name: String, surname: String) {
        self.name = name
        self.surname = surname
    }
    
    func greetings() -> String {
        return "Hello, \(name)!"
    }
}

import Quick
import Nimble


class TestPerson: QuickSpec {
    
    override func spec() {
        let person = Person(name: "Gonzalo", surname: "Barrios")
        describe("Person") {
            it("should return the proper greeting when calling greetings func") {
                XCTAssertEqual(person.greetings(), "Hello, Gonzalo!")
            }
        }
    }
}












