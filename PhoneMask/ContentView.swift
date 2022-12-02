//
//  ContentView.swift
//  PhoneMask
//
//  Created by admin on 30.11.2022.
//

import SwiftUI
import Foundation


class MyFormatter {
    /// mask example: `+X (XXX) XXX-XXXX`
    func format(phone:String) -> String {
        let rusPhone: [Character] = ["7", "8", "9"]
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result:String = ""
        var firstSimbol = numbers.prefix(1)
        
        if  rusPhone.contains(firstSimbol) {
            firstSimbol = firstSimbol == "8" ? "+7" : "+7"
            result = firstSimbol + " ("
            if (numbers.count > 1) { result += numbers.customSubString(from: 1, to: numbers.count > 4 ? 4 : numbers.count) }
            if (numbers.count >= 5) { result += ") " + numbers.customSubString(from: 4, to: numbers.count > 7 ? 7 : numbers.count) }
            if (numbers.count >= 8) { result += " " + numbers.customSubString(from: 7, to: numbers.count > 9 ? 9 : numbers.count) }
            if (numbers.count >= 10) { result += " " + numbers.customSubString(from: 9, to: numbers.count > 11 ? 11 : numbers.count) }
            
            print(result)
            
        }else{
//             add phone mask your country here
        }
        
        return result
    }
}


struct ContentView: View {
    
    @State private var myText:String = ""
    @State private  var old = ""
    private var formater = MyFormatter()
    @State var showDetail = false
    var body: some View {
        
        VStack {
            
            Button("detail", action: {
                showDetail.toggle()
            })
            
            TextField("+7 (000) 000 00 00", text: $myText)
                .keyboardType(.numberPad)
                .onChange(of: myText) { newValue in
                    myText = formater.format(phone: newValue)
                   // you can choose combine in place of event onChanged
                }
            
        }
        .padding()
        .sheet(isPresented: $showDetail) {
            Detail()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension String {
    
    func customSubString(from: Int, to: Int) -> String {
        
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[startIndex..<endIndex])
    }
}


