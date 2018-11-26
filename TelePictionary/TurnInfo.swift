//
//  TurnInfo.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 2/2/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func stringByAppendingPathComponent(_ path: String) -> String {
        
        let nsSt = self as NSString
        return nsSt.appendingPathComponent(path)
    }
}


struct TurnSearchInfo {
    var gameturnid: String
    var mediatype: String
    var gamename: String
    var viewstatus: String
    var gameid: String
    var theImage: UIImage
    var URL: String
    //var location: String
    init(gameturnid: String, mediatype: String, gamename: String, viewstatus: String, gameid: String, theImage: UIImage, URL: String) {
        self.gameturnid = gameturnid
        self.mediatype = mediatype
        self.gamename = gamename
        self.viewstatus = viewstatus
        self.gameid = gameid
        self.theImage = theImage
        self.URL = URL
    }
}

struct TurnSearchInfoFollow {
    var gameturnid: String
    var mediatype: String
    var gamename: String
    var viewstatus: String
    var gameid: String
    var theImage: UIImage
    var URL: String
    var canView: Bool
    var playername: String
    //var location: String
    init(gameturnid: String, mediatype: String, gamename: String, viewstatus: String, gameid: String, theImage: UIImage, URL: String, canView: Bool, playername: String) {
        self.gameturnid = gameturnid
        self.mediatype = mediatype
        self.gamename = gamename
        self.viewstatus = viewstatus
        self.gameid = gameid
        self.theImage = theImage
        self.URL = URL
        self.canView = canView
        self.playername = playername
    }
}
