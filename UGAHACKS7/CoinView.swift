
//  CoinView.swift
//  NCRWallet
//
//  Created by Matthew Gayle on 2/19/22.
//


import SwiftUI
/* URL https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&page=1&sparkline=true&price_change_percentage=24h
 */

struct CoinView: View {
    
    let logo: String
    let coinName: String
    let colorScheme: Color
    
    @ObservedObject var coinInfo = GetData()
    //let coin: CoinModel
    
    
    
    var body: some View {
        
        
        
        ZStack {
            colorScheme
                .ignoresSafeArea()
                
            VStack(spacing : 80) {
                HStack {
                    
                    Image(logo)
                        .resizable()
                        .frame(width: 100, height: 50)
                                       
                    
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
                    .shadow(color: .black, radius: 5)
    
                    
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
        }// ZSTACK
        
        
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


