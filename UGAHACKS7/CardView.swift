//
//  CardView.swift
//  UGAHACKS7
//
//  Created by Arth Patel on 2/19/22.
//

import SwiftUI

struct CardView: View {
    
    var card: Card
  
    
    
    var body: some View {
      
     /*   Image(card.image)
            .resizable()
            .scaledToFit()
            .overlay(*/
                VStack (alignment: .leading) {
                Text(card.cryptoName)
                    .bold()
                HStack {
                    Text(card.address)
                        .bold()
                }
                }
            
                .foregroundColor(.red)
            .padding(.leading,25)
            .padding(.bottom, 20)
      
            
        
    
        
        
    }
}

