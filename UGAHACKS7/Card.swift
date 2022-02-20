//
//  Card.swift
//  UGAHACKS7
//
//  Created by Arth Patel on 2/19/22.
//

import Foundation


enum CardType: String {
    case chase
}


struct Card: Identifiable {
    var id = UUID()
    var name: String
    var type: CardType
    var number: String
    var expiryDate: String
   
    var image: String {
        return type.rawValue
    }
}

let testCards = [ Card(name: "James Hayward", type: .chase, number: "4242 4242 4242 4242", expiryDate: "3/23"),
              Card(name: "Cassie Emily", type: .chase, number: "5353 5353 5353 5353", expiryDate: "10/21"),
              Card(name: "Adam Green", type: .chase, number: "3737 3737 3737 3737", expiryDate: "8/22"),
              Card(name: "Donald Wayne", type: .chase, number: "6363 6263 6362 6111", expiryDate: "11/23"),
              Card(name: "Gloria Jane", type: .chase, number: "6011 0009 9013 9424", expiryDate: "5/24")
    ]
