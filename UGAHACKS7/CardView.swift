//
//  CardView.swift
//  UGAHACKS7
//
//  Created by Arth Patel on 2/19/22.
//

import SwiftUI

struct CardView: View {
    
    var card: Card
  
    @Binding var address: String
    @Binding var isPresent: Bool
   let coinName: String
    let coins : [DataLayout]
    
    var body: some View {
      
        Rectangle()
            .fill(LinearGradient(colors: [Color("CustomGreen"),Color("CustomGreen2")], startPoint: .bottom, endPoint: .top))
            .frame(width: 315, height: 210, alignment: .center)
            .cornerRadius(30)
      
            .shadow(color: .black.opacity(!isPresent ? 0.1 : 0), radius: 20, x: 0, y: 2)
        
           
            .overlay(
                HStack {
                    VStack (alignment: .leading){
                        ForEach(coins) { item in
                            VStack {
                            if (item.name == card.cryptoName) {
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
                                 
                                Text(card.cryptoName)
                                       
                                            .fontWeight(.bold)
                            }
                            
                         
                        }
                        
                       
                        }
                         Spacer()
                       
                            Text(card.address)
                            .fontWeight(.bold)
                            .padding(.trailing,20)
                      
                                
                                
                    }
                    .padding(15)
                    Spacer()
                    
                        
                   
                    
                    VStack (alignment: .center) {

                        AsyncImage(url: URL(string: "https://www.bitcoinqrcodemaker.com/api/?style=\(coinName)&address=\(address)"),
                                   content: { image in
                                   image
                                     .resizable()
                                     .aspectRatio(contentMode: .fit)
                                 }, placeholder: {
                                   Color.gray
                                 }

                        )
                            .frame(width: 100, height: 100)
                            
                
                }
                
                }
                    .padding(.trailing,20)
            
                .foregroundColor(.white)
            .padding(.leading,5)
            .padding(.bottom)
                , alignment: .bottomLeading)
        
            
        
    
        
        
    }
}

