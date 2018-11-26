//
//  MyURLProtocol.swift
//  TelePictionary
//
//  Created by Jared Stevens on 7/23/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import UIKit

var requestCount = 0

class MyURLProtocol: URLProtocol {
    
    override class func canInit(with request: URLRequest) -> Bool {
        print("Request #\(requestCount += 1): URL = \(request.url!.absoluteString)")
        return false
    }
   
}
