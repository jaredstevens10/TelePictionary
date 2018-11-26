//
//  QueryItemRepresentable.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 10/28/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import Foundation

import Foundation

protocol QueryItemRepresentable {
    var queryItem: URLQueryItem { get }
    
    static var queryItemKey: String { get }
}
