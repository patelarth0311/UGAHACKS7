//
//  Data.swift
//  UGAHACKS7
//
//  Created by Arth Patel on 2/23/22.
//

import Foundation

public class GetData: ObservableObject {
    @Published var coins = [DataLayout]()
  
    init() {
        load()
       
    }
   
    

    func load() {
        let dataUrl = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=dogecoin%2C%20ethereum%2Cbitcoin%2C%20cardano&order=market_cap_desc&per_page=100&page=1&sparkline=false")!
        
        let decoder = JSONDecoder()
        
        URLSession.shared.dataTask(with: dataUrl) {(data,response,error) in
            do {
                if let d = data {
                    let decodedLists = try decoder.decode([DataLayout].self, from: d)
                   
                    
                    
                    
                        DispatchQueue.main.async {
                            self.coins = decodedLists
                            print(self.coins)
                        }
                    
                   
                    
                } else {
                    print("No Data")
                }
                
            } catch {
              
                print("error")
            }
            
        } .resume()

    }
    
}

struct DataLayout: Codable, Identifiable {
    public var id : String
    public var symbol  : String
    public var name : String
    public var image : String
    public var current_price : Float
 
    
    
    
    enum CodingKeys: String, CodingKey {
       
        case id = "id"
        case symbol  = "symbol"
        case name = "name"
        case image = "image"
        case current_price = "current_price"
        

        }


        
    
    
}



