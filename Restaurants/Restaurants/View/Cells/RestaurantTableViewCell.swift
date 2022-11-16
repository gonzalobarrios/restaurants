//
//  RestaurantTableViewCell.swift
//  Restaurants
//
//  Created by Gonzalo on 11/13/22.
//

import Foundation
import UIKit

class RestaurantTableViewCell: UITableViewCell {

    var restaurant: Restaurant? {
        didSet {
            if let url = restaurant?.mainPhoto?.s92x92 {
                mainImageView.loadImage(at: url)
            }
            nameLabel.text = restaurant?.name
            ratingLabel.text = "Rating: \(restaurant?.ratings.tripadvisor.ratingValue ?? 0.0)"
            if UserDefaults.standard.bool(forKey: restaurant?.uuid ?? "") {
                heartButton.setImage(UIImage(named: "heart-full"), for: .normal)
            } else {
                heartButton.setImage(UIImage(named: "heart-empty"), for: .normal)
            }
        }
    }

    //MARK: UI Components
    private let mainImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    private let heartButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(named: "heart-empty"), for: .normal)
        return button
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()

    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .gray
        return label
    }()

    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        contentView.autoresizingMask = .flexibleHeight
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: Setup UI
    private func setupViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(mainImageView)
        mainImageView.addSubview(heartButton)
        heartButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        mainImageView.setConstraints(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 0, width: 130, height: 130, enableInsets: false)
        
        heartButton.setConstraints(top: nil, left: nil, bottom: mainImageView.bottomAnchor, right: mainImageView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 5, paddingRight: 5, width: 30, height: 30, enableInsets: false)
        
        nameLabel.setConstraints(top: contentView.topAnchor, left: mainImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        ratingLabel.setConstraints(top: nameLabel.bottomAnchor, left: mainImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        mainImageView.image = nil
    }
    
    //MARK: Actions
    @objc func buttonAction(sender: UIButton!) {
        if UserDefaults.standard.bool(forKey: restaurant?.uuid ?? "") {
            UserDefaults.standard.removeObject(forKey: restaurant?.uuid ?? "")
            heartButton.setImage(UIImage(named: "heart-empty"), for: .normal)
        } else {
            UserDefaults.standard.set(true, forKey: restaurant?.uuid ?? "")
            heartButton.setImage(UIImage(named: "heart-full"), for: .normal)
        }
    }
}
