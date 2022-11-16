//
//  HomeViewController.swift
//  Restaurants
//
//  Created by Gonzalo on 11/12/22.
//

import Foundation
import UIKit
import Combine

class HomeViewController: UIViewController {

    //MARK: Properties

    private var viewModel: HomeViewModel!
    private var subscriber: AnyCancellable?
    
    var restaurants: [Restaurant] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: UI Components
    
    private let headerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 70))
        view.backgroundColor = .black
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Restaurants"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    //MARK: LifeCycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupViews()
        setupViewModel()
        observeViewModel()
    }

    //MARK: Setups
    private func observeViewModel() {
        subscriber = viewModel.restaurantSubject.sink(receiveCompletion: { (resultCompletion) in
            switch resultCompletion {
            case .failure(let error):
                print(error.localizedDescription)
            case .finished: break
            }
        }) { (restaurants) in
            self.restaurants = restaurants
        }
    }

    private func setupViewModel() {
        viewModel = HomeViewModel(apiManager: APIManager(), endpoint: .restaurants)
        viewModel.fetchRestaurants()
    }

    // MARK: Setups
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(RestaurantTableViewCell.self, forCellReuseIdentifier: "RestaurantTableViewCell")
        self.tableView.separatorStyle = .none
    }

    private func setupViews() {
        let margins = view.layoutMarginsGuide

        self.view.addSubview(headerView)
        self.view.addSubview(tableView)
        self.headerView.addSubview(titleLabel)
        
        headerView.setConstraints(top: margins.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.size.width, height: 70, enableInsets: true)

        tableView.setConstraints(top: headerView.bottomAnchor, left: view.leftAnchor, bottom: margins.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.size.width, height: 0, enableInsets: true)
        
        titleLabel.setConstraints(top: margins.topAnchor, left: headerView.leftAnchor, bottom: headerView.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: true)
    }

}

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as! RestaurantTableViewCell
        let restaurant = restaurants[indexPath.row]
        cell.restaurant = restaurant
        return cell
    }
}
