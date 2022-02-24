
//  CoinView.swift
//
//
//  Created by Matthew Gayle on 2/19/22.
//


import SwiftUI
import Foundation
import Combine
/* URL https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin%2C%20dogecoin%2C%20ethereum%2C%20bitcoin-cash&order=market_cap_desc&per_page=100&page=1&sparkline=false
 */

struct CoinView: View {
    
    let logo: String
    let coinName: String
    let colorScheme: Color
    let coins : [DataLayout]
    
    
    @Binding  var closeScreen: Bool
    
    //let coin: CoinModel
    
    
    
    var body: some View {
        
        
        
        ZStack {
            colorScheme
                .ignoresSafeArea()
                
          
            
            
            
            VStack(spacing : 80) {
                VStack {
                    ForEach(coins) { item in
                        
                        if (item.name == coinName) {
                            
                            HStack {
                            AsyncImage(url: URL(string: "\(item.image)"),
                                       content: { image in
                                       image
                                         .resizable()
                                         .aspectRatio(contentMode: .fit)
                                     }, placeholder: {
                                       Color.gray
                                     }

                            )
                                .frame(width: 70, height: 70)
                               
                           
                          
                                
                                               
                            
                            Text(item.name)
                                .fontWeight(.bold)
                                .font(.largeTitle)
                               
                                               
                            
                                .padding()
                            }
                            .foregroundColor(.black)
                            
                            VStack {
                              
                                Text("Price: $\(item.current_price, specifier: "%.2f")")
                                .bold()
                            
                                .font(.system(size:25))
                                
                
                                
                            }
                            .foregroundColor(.black)
                        } // HSTACK
                     
                        }
                    
                        
                    }
                

             
                    
                
                
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







struct MakeButtons: View {
    var text:String
    var color:Color
    var body: some View {
        HStack {
            
            Button(action: {
                
            }) {
                Capsule()
                    .fill(Color("CustomGreen"))
                    .frame(width:150,height:60)
                    .foregroundColor(.white)
                    .overlay(
                        Text(text)
                            .fontWeight(.bold)
                            .font(.system(size: 20)))
                    .foregroundColor(color)
                
            }
        }
    }
}











