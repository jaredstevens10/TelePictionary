//
//  TurnParts.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 10/28/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import UIKit


protocol TurnParts {
    var rawValue: String { get }
    
    var image: UIImage { get }
    
    var stickerImage: UIImage { get }
}

/*
struct TurnParts {
    
    var rawValue: String
    var image: UIImage
    var stickerImage: UIImage
    
}
*/

enum currentUser: String, TurnParts, QueryItemRepresentable {
    case topping01, topping02, topping03, topping04, topping05, topping06, topping07, topping08, topping09, topping10, topping11, topping12
    
    static let all: [currentUser] = [.topping01, .topping02, .topping03, .topping04, .topping05, .topping06, .topping07, .topping08, .topping09, .topping10, .topping11, .topping12]
    
    static var queryItemKey: String {
        return "currentUser"
    }
}

enum lastUser: String, TurnParts, QueryItemRepresentable {
    case scoops01, scoops02, scoops03, scoops04, scoops05, scoops06, scoops07, scoops08, scoops09, scoops10
    
    static let all: [lastUser] = [.scoops01, .scoops02, .scoops03, .scoops04, .scoops05, .scoops06, .scoops07, .scoops08, .scoops09, .scoops10]
    
    static var queryItemKey: String {
        return "lastUser"
    }
}

enum TurnType: String, TurnParts, QueryItemRepresentable {
    case base01, base02, base03, base04
    
    static let all: [TurnType] = [.base01, .base02, .base03, .base04]
    
    static var queryItemKey: String {
        return "TurnType"
    }
}



/// Extends `IceCreamPart` to provide a default implementation of the `image` and `stickerImage` properties.
extension TurnParts {
    var image: UIImage {
        let imageName = self.rawValue
        guard let image = UIImage(named: imageName) else { fatalError("Unable to find image named \(imageName)") }
        return image
    }
    
    var stickerImage: UIImage {
        let imageName = "\(self.rawValue)_sticker"
        guard let image = UIImage(named: imageName) else { fatalError("Unable to find image named \(imageName)") }
        return image
    }
}

/**
 Extends instances of `QueryItemRepresentable` that also conformt to `IceCreamPart`
 to provide a default implementation of `queryItem`.
 */
extension QueryItemRepresentable where Self: TurnParts {
    var queryItem: URLQueryItem {
        return URLQueryItem(name: Self.queryItemKey, value: rawValue)
    }
}

