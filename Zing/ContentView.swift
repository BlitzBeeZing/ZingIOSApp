//
//  ContentView.swift
//  Zing
//
//  Created by Adarsh Shukla on 02/02/23.
//

import SwiftUI

struct OTPInputField: View {
    @Binding var code: String

    let numOfDigits: Int

    var body: some View {
        HStack {
            ForEach(0 ..< numOfDigits, id: \.self) { digit in
                TextField("", text: self.$code, onEditingChanged: { isEditing in
                    if !isEditing {
                        self.code = String(self.code.prefix(self.numOfDigits))
                    }
                })
                .frame(width: 44, height: 44)
                .border(Color.black, width: 1)
                .padding(.horizontal, 8)
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
            }
        }
    }
}

struct ContentView: View {
    @State var code = ""

    var body: some View {
        VStack {
            OTPInputField(code: $code, numOfDigits: 6)
            Text("Code: \(code)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
