//
//  Wallet.swift
//  UGAHACKS7
//
//  Created by Arth Patel on 2/19/22.
//

import SwiftUI

struct Wallet: View {
    
    @State var cards: [Card] = [Card]()
  
    @State private var isCardPresent = false;
    @State var selectedCard: Card?
    private static let cardOffset: CGFloat = 40.0
    @State private var isCardPressed = false;
    @GestureState private var dragState = DragState.inactive

    @State private var willMoveToNextScreen = false;
    
    @State private var submitState = false;
    
    @State private var address = ""
    
  
    var body: some View {
        
        
        VStack {
            
            TopNavBar(willMoveToNextScreen: $willMoveToNextScreen, submitState: $submitState, list: $cards, address: $address)
            
            Spacer()
            
            
            ZStack {
                if isCardPresent {
                    
                    
                    ForEach(cards) { card in
                        
                        CardView(card: card, address: $address)
                          
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
                                    .exclusively(before: LongPressGesture(minimumDuration: 0.05)
                                                    .sequenced(before: DragGesture())
                                                    .updating(self.$dragState, body: {(value, state, transition) in
                                                        
                                                        switch value {
                                                        case .first(true):
                                                            state = .pressing(index: self.index(for: card))
                                                        case .second(true, let drag) :
                                                            state = .dragging(index: self.index(for: card), translation: drag? .translation ?? .zero)
                                                        default:
                                                            break
                                                        }
                                                    })
                                                    .onEnded({ (value) in
                                                        guard case .second(true, let drag?) = value else {
                                                            return
                                                        }
                                                        
                                                        
                                                        self.rearrangeCards(with: card, dragOffset: drag.translation)
                                                    })
                                                )
                            )
                        
                       
                        
                        
                        
                    }
                }
                
                
            }
            .onAppear {
                isCardPresent.toggle()
            }
           
            Spacer()
            
            
        }
        .fullScreenCover(isPresented: $isCardPressed) {
            CoinView(logo: "bitcoinlogo", coinName: "Bitcoin", colorScheme: .orange)
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
        
        
        let defaultZIndex = -Double(cardIndex)
        
        if let draggingIndex = dragState.index,
           cardIndex == draggingIndex {
            
            return defaultZIndex + Double(dragState.translation.height/Self.cardOffset)
        }
        
        return -Double(cardIndex)
    }
    
    private func offset(for card: Card) -> CGSize {
        
        
        
        
        guard let cardIndex = index(for: card) else {
            return CGSize()
        }
        
        if isCardPressed {
         
            guard let selectedCard = self.selectedCard,
                  let selectedCardIndex = index(for: selectedCard) else {
                      
                      return .zero
                  }
            
            if cardIndex >= selectedCardIndex {
                return .zero
            }
            
            
            let offset = CGSize(width: 0, height: 1400)
            
            return offset
            
            
            
        }
        
        // Handing drag
        
        var pressedOffset = CGSize.zero
        var dragOffsetY: CGFloat = 0.0
        
        if let draggingIndex = dragState.index,
           cardIndex == draggingIndex {
            pressedOffset.height = dragState.isPressing ? -20 : 0
            
            switch dragState.translation.width {
            case let width where width < -10: pressedOffset.width = -20
            case let width where width > 10: pressedOffset.width = 20
            default: break
            }
            dragOffsetY = dragState.translation.height
        }
           
            
            return CGSize(width: 0 + pressedOffset.width, height: -50 * CGFloat(cardIndex) + pressedOffset.height +  dragOffsetY)
            
        
    }


    
    /* Card slide animation helper functions*/
    
    private func transitionAnimation(for card: Card) -> Animation {
        var delay = 0.0
        
        if let index = index(for: card) {
            delay = Double(cards.count - index) * 0.1
        }
        
        return Animation.spring(response: 0.1, dampingFraction: 0.8, blendDuration: 0.02).delay(delay)
    }
    
    
    
    private  func rearrangeCards(with card: Card, dragOffset: CGSize) {
        guard let draggingCardIndex = index(for: card) else {
            return
        }
        
        var newIndex = draggingCardIndex + Int(-dragOffset.height/Self.cardOffset)
        newIndex = newIndex >= cards.count ? cards.count - 1 : newIndex
        newIndex = newIndex < 0 ? 0 : newIndex
        
        let removedCard = cards.remove(at: draggingCardIndex)
        cards.insert(removedCard, at :newIndex)
        
        
    }
    
    
}










struct TopNavBar: View {
    
    @Binding var willMoveToNextScreen : Bool
    
    @Binding var submitState: Bool
    
    @Binding var list: [Card]
    
    
    @Binding var address : String
    
    var body : some View {
        HStack {
            Text("Wallet")
                .font(.system(.largeTitle,design: .rounded))
                .fontWeight(.heavy)
            
            Spacer()
            
            Button {
                
                willMoveToNextScreen.toggle()
                
            } label : {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(Color("CustomGreen"))
                    .font(.system(size: 30))
                    
            }
        }
        .fullScreenCover(isPresented: $willMoveToNextScreen) {
            CreateNewWallet(address: $address, willMoveToNextScreen: $willMoveToNextScreen,  submitState: $submitState, list: $list)
        }
        
        .padding(.horizontal)
        .padding(.top,20)
        
    }
    
}





enum DragState {
    case inactive
    case pressing(index: Int? = nil)
    case dragging(index: Int? = nil, translation: CGSize)
    
    
    var index: Int? {
        switch self {
        case .pressing(let index), .dragging(let index, _) :
            return index
        case .inactive :
            return nil
        }
    }
    
    var translation: CGSize {
        switch self {
        case .inactive, .pressing:
            return .zero
        case .dragging(_, let translation):
            return translation
        }
    }
    
    var isPressing: Bool {
        switch self {
        case .pressing, .dragging:
            return true
        case .inactive:
            return false
        }
    }
    
    var isDragging: Bool {
        switch self {
        case .dragging:
            return true
        case .inactive, .pressing:
            return false
        }
    }
    
    
}


