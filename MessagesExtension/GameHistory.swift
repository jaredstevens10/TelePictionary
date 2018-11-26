//
//  GameHistory.swift
//  TelePictionary
//
//  Created by Jared Stevens2 on 10/27/16.
//  Copyright © 2016 Claven Solutions. All rights reserved.
//



import Foundation

struct GameTurnHistory {
    // MARK: Properties
    
    private static let maximumHistorySize = 50
    
    private static let userDefaultsKey = "iceCreams"
    
    /// An array of previously created `IceCream`s.
    fileprivate var AllTurns: [TurnInfo]
    
    var count: Int {
        return AllTurns.count
    }
    
    subscript(index: Int) -> TurnInfo {
        return AllTurns[index]
    }
    
    // MARK: Initialization
    
    /**
     `IceCreamHistory`'s initializer is marked as private. Instead instances should
     be loaded via the `load` method.
     */
    private init(AllTurns: [TurnInfo]) {
        self.AllTurns = AllTurns
    }
    
    /// Loads previously created `IceCream`s and returns a `IceCreamHistory` instance.
    static func load() -> GameTurnHistory {
        var AllTurns = [TurnInfo]()
        let defaults = UserDefaults.standard
        
        if let savedTurns = defaults.object(forKey: GameTurnHistory.userDefaultsKey) as? [String] {
            AllTurns = savedTurns.flatMap { urlString in
                guard let url = URL(string: urlString) else { return nil }
                guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false), let queryItems = components.queryItems else { return nil }
               // return ["test","test2"]
                return TurnInfo(queryItems: queryItems)
            }
        }
        
        // If no ice creams have been loaded, create some tasty examples.
        if AllTurns.isEmpty {
            /*
            iceCreams.append(IceCream(base: .base01, scoops: .scoops01, topping: .topping01))
            iceCreams.append(IceCream(base: .base02, scoops: .scoops02, topping: .topping02))
            iceCreams.append(IceCream(base: .base03, scoops: .scoops03, topping: .topping03))
            iceCreams.append(IceCream(base: .base04, scoops: .scoops04, topping: .topping04))
            
            */
            let historyToSave = GameTurnHistory(AllTurns: AllTurns)
            historyToSave.save()
        }
        
        return GameTurnHistory(AllTurns: AllTurns)
    }
    
    /// Saves the history.
    func save() {
        // Save a maximum number ice creams.
        let AllTurnsToSave = AllTurns.suffix(GameTurnHistory.maximumHistorySize)
        
        // Map the ice creams to an array of URL strings.
        let TurnInfoURLStrings: [String] = AllTurnsToSave.flatMap { TurnINfo in
            var components = URLComponents()
            //components.queryItems = TurnInfo.queryItems
            
            return components.url?.absoluteString
        }
        
        let defaults = UserDefaults.standard
        defaults.set(TurnInfoURLStrings as AnyObject, forKey: GameTurnHistory.userDefaultsKey)
    }
    
    mutating func append(_ turnInfo: TurnInfo) {
        /*
         Filter any existing instances of the new ice cream from the current
         history before adding it to the end of the history.
         */
        //var newTurnInfo = [TurnInfo]()
        var newTurnInfo = self.AllTurns.filter { $0 != turnInfo }
        //newTurnInfo.append(TurnInfo.init(message: ""))
        
        AllTurns = newTurnInfo
    }
}



/**
 Extends `IceCreamHistory` to conform to the `Sequence` protocol so it can be used
 in for..in statements.
 */
extension GameTurnHistory: Sequence {
    typealias Iterator = AnyIterator<TurnInfo>
    
    func makeIterator() -> Iterator {
        var index = 0
        
        return Iterator {
            guard index < self.AllTurns.count else { return nil }
            
            let turnInfo = self.AllTurns[index]
            index += 1
            
            return turnInfo
        }
    }
}
