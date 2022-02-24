//
//  CreateNewWallet.swift
//  UGAHACKS7
//
//  Created by Arth Patel on 2/19/22.
//

import SwiftUI

struct CreateNewWallet: View {
    
    @Binding var address: String 
    
    @State private var selection = ""
    
    @Binding  var willMoveToNextScreen: Bool
    @Binding  var  submitState : Bool
    
    @Binding var list: [Card]
    
    
    let options = ["Bitcoin", "Ethereum","Dogecoin", "Cardano"]
    var body: some View {
        
        ZStack {
        VStack (alignment: .center, spacing: 50){
          Spacer()
            Picker("Select a Cryptocurrency", selection: $selection) {
                ForEach(options, id: \.self) {
                    Text($0)
                       
                     
                      
                }
            }
            
          
            .pickerStyle(.segmented)
            

          
            Text("Selected currency: \(selection)")
                .font(.system(size: 20, weight: .semibold, design: .default))
            
          
            
            Capsule()
                .fill(Color("CustomGreen"))
                 .frame(width: 300, height: 60)
                
                .overlay(
            HStack (alignment: .center){
          
            
         
                TextField("Address", text: $address)
                    .textCase(.none)
                    .foregroundColor(.white)
                    
            }
                .padding()
                 
            )
            
            if (address.isEmpty == false && selection.isEmpty == false) {
            Capsule()
                .fill(Color("CustomGreen"))
                
                .frame(width: 100, height: 60)
                
                .overlay(
                    
            Button {
                
                
                
                submitState = false;
                willMoveToNextScreen.toggle()
                
                let newCard =  Card(cryptoName: selection , type: selection, address: address)
                

                
                list.append(newCard)
                
                address = "";
                
                
            } label : {
                
              Text("Submit")
                    .fontWeight(.semibold)
                    .font(.system(.callout, design: .default))
                    .foregroundColor(.white)
            }
            )
    
            }
           
            
         
            Spacer()
                
            
        }
        .padding()
            
            Button {
                
                willMoveToNextScreen.toggle()
                
                
                
            } label: {
                VStack (alignment: .center) {
                    
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color("CustomGreen"))
                        .font(.system(size: 30))
                }
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding()
            
            
        }
       
    }
}


