//
//  Wallet.swift
//  UGAHACKS7
//
//  Created by Arth Patel on 2/19/22.
//

import SwiftUI

struct Wallet: View {
    
    var cards: [Card] = testCards
    @State private var isCardPressed = false;
    @State var selectedCard: Card?
    
    var body: some View {
       
        
        VStack {
            TopNavBar()
           
            Spacer()
            
            
            ZStack {
                if isCardPressed {
                ForEach(cards) { card in
                    CardView(card: card)
                        .padding(.horizontal,35)
                        .zIndex(self.zIndex(for: card))
                        .offset(self.offset(for: card))
                        .transition((AnyTransition.slide.combined(with: .move(edge:.leading)).combined(with:.opacity)))
                        .animation(self.transitionAnimation(for: card), value: false)
                        .gesture(
                        TapGesture()
                            .onEnded({ _ in
                                
                                withAnimation(.easeOut(duration: 0.15).delay(0.1)) {
                                    self.isCardPressed.toggle()
                                    self.selectedCard = self.isCardPressed ? card : nil
                                }
                                
                                
                                
                            })
                        
                        
                        
                        )
           
                }
                }
                
                    
            }
            .onAppear {
                isCardPressed.toggle()
            }
            Spacer()
            
            
        }
    }
    
    
    
    
    
    
    /* Helper functions that help set Z-index of the CardView*/



    private func index(for card: Card) -> Int? {
        
        guard let index = cards.firstIndex(where: {$0.id == card.id}) else {
            return nil
        }
        
        return index
    }



    private func zIndex(for card: Card) -> Double {
        guard let cardIndex = index(for: card) else {
            return 0.0
        }
        
        return -Double(cardIndex)
    }
    
    private func offset(for card: Card) -> CGSize {
        guard let cardIndex = index(for: card) else {
            return CGSize()
        }
        
        return CGSize(width: 0, height: -50 * CGFloat(cardIndex))
    }
    
        /* Card slide animation helper functions*/
    
    private func transitionAnimation(for card: Card) -> Animation {
        var delay = 0.0
        
        if let index = index(for: card) {
            delay = Double(cards.count - index) * 0.1
        }
        
        return Animation.spring(response: 0.1, dampingFraction: 0.8, blendDuration: 0.02).delay(delay)
    }

    

}









struct TopNavBar: View {
    
    var body : some View {
    HStack {
        Text("Wallet")
            .font(.system(.largeTitle,design: .rounded))
            .fontWeight(.heavy)
        
        Spacer()
        
        Button {
            
        } label : {
            Image(systemName: "plus.circle.fill")
                .font(.system(.title))
        }
    }
    .padding(.horizontal)
    .padding(.top,20)
    
    }
    
}
