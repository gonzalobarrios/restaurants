//
//  UIImageView+download.swift
//  Restaurants
//
//  Created by Gonzalo on 11/15/22.
//

import Foundation
import UIKit

extension UIImageView {
  func loadImage(at url: String) {
    UIImageLoader.loader.load(url, for: self)
  }

  func cancelImageLoad() {
    UIImageLoader.loader.cancel(for: self)
  }
}
