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
      
        Image(card.image)
            .resizable()
            .scaledToFit()
            .overlay(
                VStack (alignment: .leading) {
                Text(card.number)
                    .bold()
                HStack {
                    Text(card.name)
                        .bold()
                    Text("Valid Thru")
                        .font(.footnote)
                    Text(card.expiryDate)
                        .font(.footnote)
                }
                }
            
            .foregroundColor(.white)
            .padding(.leading,25)
            .padding(.bottom, 20)
                , alignment: .bottomLeading)
            
        
    
        
        
    }
}

