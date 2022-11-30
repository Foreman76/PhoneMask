//
//  ContentView.swift
//  PhoneMask
//
//  Created by admin on 30.11.2022.
//

import SwiftUI
import Foundation

struct ContentView: View {
    
    @State private var myText:String = ""
    
    var body: some View {
        
        VStack {
            TextField("+7 (000) 000 00 00", value: $myText, formatter: PhoneFormatter())
        }
        .padding()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





