//
//  Packet.swift
//  TelePictionary
//
//  Created by Jared Stevens on 9/13/15.
//  Copyright (c) 2015 Claven Solutions. All rights reserved.
//

import Foundation

/**
*  Packet
*/
struct Packet {
    var name: String
    var index: Int64
    var numberOfPackets: Int64
    
    /**
    *  Struc
    */
    struct ArchivedPacket {
        var index : Int64
        var numberOfPackets : Int64
        var nameLength : Int64
    }
    /**
    Archive Packet
    
    - returns: NSData
    */
          //SWIFT 3 ERROR
    /*
    func archive() -> Data {
        
        var archivedPacket = ArchivedPacket(index: Int64(self.index), numberOfPackets: Int64(self.numberOfPackets), nameLength: Int64(self.name.lengthOfBytes(using: String.Encoding.utf8)))
        
        //SWIFT 3 ERROR
        
        let metadata = Data(
            bytes: UnsafePointer(&archivedPacket),
          //  bytes: UnsafePointer<UInt8>(&archivedPacket),
            count: sizeof(ArchivedPacket)
        )
 
        
        let archivedData = NSData(data: metadata) as Data
        archivedData.append(name.data(using: String.Encoding.utf8, allowLossyConversion: false)!)
        
        return archivedData
    }
 */
    /**
    Unarchive Packet
    
    - parameter data: NSData
    
    - returns: Packet
    */
    
     //SWIFT 3 ERROR
    /*
    static func unarchive(_ data: Data!) -> Packet {
        var archivedPacket = ArchivedPacket(index: 0, numberOfPackets: 0, nameLength: 0) //, dataLength: 0
        let archivedStructLength = MemoryLayout<ArchivedPacket>.size
        
        let archivedData = data.subdata(in: NSMakeRange(0, archivedStructLength))
        (archivedData as NSData).getBytes(&archivedPacket)
        
        let nameRange = NSMakeRange(archivedStructLength, Int(archivedPacket.nameLength))
        let nameData = data.subdata(in: nameRange)
        let name = NSString(data: nameData, encoding: String.Encoding.utf8) as! String
        let packet = Packet(name: name, index: archivedPacket.index, numberOfPackets: archivedPacket.numberOfPackets)
        
        return packet
    }
    */
}
