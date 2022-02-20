
//  CoinView.swift
//
//
//  Created by Matthew Gayle on 2/19/22.
//


import SwiftUI
import Foundation
/* URL https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin%2C%20dogecoin%2C%20ethereum%2C%20bitcoin-cash&order=market_cap_desc&per_page=100&page=1&sparkline=false
 */

struct CoinView: View {
    
    let logo: String
    let coinName: String
    let colorScheme: Color
    
    @Binding  var closeScreen: Bool
    
    @ObservedObject var coinInfo = GetData()
    //let coin: CoinModel
    
    
    
    var body: some View {
        
        
        
        ZStack {
            colorScheme
                .ignoresSafeArea()
                
            VStack(spacing : 80) {
                HStack {
                    
                    Image(logo+"1")
                        .resizable()
                        .frame(width: 100, height: 100)
                                       
                    
                    Text(coinName)
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                                       
                    
                        .padding()
                } // HSTACK
                VStack {
                Text("CURRENT PRICE:")
                    .bold()
                    .foregroundColor(.white)
                    .font(.system(size:25))
                    
    
                    
                }
//                Text("\(coin.currentPrice)")
                /*
                    Text("Hello")
                    .foregroundColor(.white)
                    .font(.system(size:25))
                    .bold()
                    .shadow(color: .black, radius: 5)
                 */
                
             
                    
                
                
                VStack {
                HStack {
                    MakeButtons(text:"Pay" , color: colorScheme)
                    MakeButtons(text:"Request", color: colorScheme)
                    
                }
                HStack {
                    MakeButtons(text: "Cash Out", color: colorScheme)
                    MakeButtons(text: "Info", color: colorScheme)
                    
                }
                }
               
            } // VStack
            
            Button {
                
                closeScreen.toggle()
                
                
                
            } label: {
                VStack (alignment: .center) {
                    
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color("CustomGreen"))
                        .font(.system(size: 30))
                }
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding()
            
        }// ZSTACK
  
        
    }
}

struct Coin : Identifiable, Codable {


        let id, symbol, name: String
        let image: String
        let currentPrice: Double
    let currentHoldings: Double?
  

    // MARK: - Roi
    struct Roi {
        let times: Double?
        let currency: String?
        let percentage: Double?
    }
    
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case currentHoldings
    }
    
    func updateHolding(amount: Double) -> Coin {
      return Coin(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, currentHoldings: currentHoldings)
    }
    
    var currentHoldingsValue : Double {
        return (currentHoldings ?? 0) * currentPrice
    }

}




struct MakeButtons: View {
    var text:String
    var color:Color
    var body: some View {
        HStack {
            
            Button(action: {
                print("BUTTON ONE")
            }) {
                Capsule()
                    .frame(width:150,height:60)
                    .foregroundColor(.white)
                    .overlay(
                        Text(text)
                            .fontWeight(.bold)
                            .font(.system(size: 25)))
                    .foregroundColor(color)
                
            }
        }
    }
}











public class GetData: ObservableObject {
    @Published var coins = [DataLayout]()
    init() {
        
        load()
    }
    
    func load() {
        let dataUrl = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&page=1&sparkline=false")!
        
        let decoder = JSONDecoder()
        
        URLSession.shared.dataTask(with: dataUrl) {(data,response,error) in
            do {
                if let d = data {
                    let decodedLists = try decoder.decode([DataLayout].self, from: d)
                    DispatchQueue.main.async {
                        self.coins = decodedLists
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
    public var id: String
    public var currentPrice: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case currentPrice = "current_price"
        
    }
    
}


extension PreviewProvider {
    
    
}
