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
    
    var body: some View {
      
        Image(card.type)
            .resizable()
            .interpolation(.none)
            .scaledToFit()
            .overlay(
                HStack {
                    Spacer()
                VStack (alignment: .trailing) {
                Text(card.cryptoName)
                        .font(.system(.largeTitle))
                            .fontWeight(.black)
                      
                    .padding(20)
                    VStack {
                   

                            QrCodeGenerator(address: $address)
                
                    Text(card.address)
                        .bold()
                }
                }
                
                }
                    .padding(.trailing,30)
            
                .foregroundColor(.white)
            .padding(.leading,25)
            .padding(.bottom, 20)
                , alignment: .bottomLeading)
        
            
        
    
        
        
    }
}

