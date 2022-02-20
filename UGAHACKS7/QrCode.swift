//
//  QrCode.swift
//  UGAHACKS7
//
//  Created by Arth Patel on 2/19/22.
//

import Foundation
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

import UIKit

struct  QrCodeGenerator : View {
    
    @Binding var address : String
    let context = CIContext();
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        VStack {
            
           
            Image(uiImage: generateQRCode(from: address))
                .resizable()
                .interpolation(.none)
                .scaleEffect()
                .frame(width: 100, height: 100, alignment: .center)
                
        }
    }
  
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    
 /*   override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: generateLink(type: "a", address: "a"))!
        
        DispatchQueue.global().async {
                // Fetch Image Data
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        // Create Image and Update Image View
                        self.imageView.image = UIImage(data: data)
                    }
                }
            }
    }*/
    
    
/*func generateLink(  type:  String,address: String)  {
        
        let url = URL(string: "https://www.bitcoinqrcodemaker.com/api/?style=" + type.lowercased() + "&address=" + address)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        
        let session = URLSession.shared

        session.dataTask(with: request) {data, response, err in
            print("Entered the completionHandler")
        }.resume()
        
        
    
        print(url)
    }*/
    
    
    
    
    
}

