//
//  CreateNewWallet.swift
//  UGAHACKS7
//
//  Created by Arth Patel on 2/19/22.
//

import SwiftUI

struct CreateNewWallet: View {
    
    @State private var address: String = ""
    
    @State private var selection = ""
    
    @Binding  var willMoveToNextScreen: Bool
    @Binding  var  submitState : Bool
    
    let options = ["Bitcoin", "Ethereum","Doge", "Cardano"]
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
            
          
            
            Capsule()
                .fill(Color.blue)
                 .frame(width: 300, height: 60)
                
                .overlay(
            HStack (alignment: .center){
          
            
         
                TextField("Address", text: $address)
                    .foregroundColor(.black)
            }
                .padding()
                 
            )
            
            if (address.isEmpty == false) {
            Capsule()
                .fill(Color.blue)
                
                .frame(width: 100, height: 60)
                
                .overlay(
                    
            Button {
                
                submitState = false;
                willMoveToNextScreen.toggle()
                
            } label : {
                
              Text("Submit")
                    .foregroundColor(.white)
            }
            )
    
            }
           
             
                QrCodeGenerator(address: $address)
            
                
            
         
            Spacer()
                
            
        }
        .padding()
            
            Button {
                
                willMoveToNextScreen.toggle()
                
                
                
            } label: {
                VStack (alignment: .center) {
                    
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 30))
                }
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding()
            
            
        }
       
    }
}


