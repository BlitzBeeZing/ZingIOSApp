//
//  OTPView.swift
//  Zing
//
//  Created by Adarsh Shukla on 03/02/23.
//

import SwiftUI

struct OTPView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var verificationCode: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("Let’s get started")
                    .font(.custom("Duplet-Bold", size: 30))
                
                Spacer()
            }
            .padding(.bottom, 4)
            
            HStack {
                Text("Enter the 6 digit code sent to +91 99863 67892 ")
                    .font(.custom("Mulish-SemiBold", size: 18))
                Spacer()
            }
            .padding(.bottom, 63)
            
            CodeView(verificationCode: $verificationCode)
                .padding(.bottom, 20)
            
            if verificationCode.count == 0 {
                HStack {
                    Text("didn’t receive code? ")
                        .font(.custom("Mulish-SemiBold", size: 14))
                        .foregroundColor(Color(hex: "F5765B"))
                    +
                    
                    Text("resend")
                        .font(.custom("Mulish-SemiBold", size: 14))
                        .foregroundColor(.black)
                        .underline()
                    
                }
            }
            
            Spacer()
            
            Rectangle()
                .foregroundColor(verificationCode.count
                                 != 6 ? Color(hex: "2B2B2B").opacity(0.5) : Color(hex: "2B2B2B"))
                .frame(height: 50)
                .overlay(alignment: .center) {
                    Text("Verify")
                        .foregroundColor(.white)
                        .font(.custom("Duplet-Bold", size: 20))
                }
            Rectangle()
                .foregroundColor(.white)
                .frame(height: 20)
        }
        .padding(.horizontal)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                }
                
            }
        }
    }
}

struct OTPView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            OTPView()
        }
    }
}

struct CodeView: View {
    
    @Binding var verificationCode: String
    @FocusState private var isOTPFeildFocused: Bool
    
    var body: some View {
        HStack(spacing: 15) {
            VStack(spacing: 8) {
                Text(verificationCode.count >= 1 ? verificationCode[0] : " ")
                    .font(.custom("Duplet-SemiBold", size: 22))
                Capsule()
                    .foregroundColor(.gray)
                    .frame(width: (UIScreen.main.bounds.width - 115) / 6, height: 2)
            }
            VStack(spacing: 8) {
                Text(verificationCode.count >= 2 ? verificationCode[1] : " ")
                    .font(.custom("Duplet-SemiBold", size: 22))
                Capsule()
                    .foregroundColor(.gray)
                    .frame(width: (UIScreen.main.bounds.width - 115) / 6, height: 2)
            }
            VStack(spacing: 8) {
                Text(verificationCode.count >= 3 ? verificationCode[2] : " ")
                    .font(.custom("Duplet-SemiBold", size: 22))
                Capsule()
                    .foregroundColor(.gray)
                    .frame(width: (UIScreen.main.bounds.width - 115) / 6, height: 2)
            }
            VStack(spacing: 8) {
                Text(verificationCode.count >= 4 ? verificationCode[3] : " ")
                    .font(.custom("Duplet-SemiBold", size: 22))
                Capsule()
                    .foregroundColor(.gray)
                    .frame(width: (UIScreen.main.bounds.width - 115) / 6, height: 2)
            }
            VStack(spacing: 8) {
                Text(verificationCode.count >= 5 ? verificationCode[4] : " ")
                    .font(.custom("Duplet-SemiBold", size: 22))
                Capsule()
                    .foregroundColor(.gray)
                    .frame(width: (UIScreen.main.bounds.width - 115) / 6, height: 2)
            }
            VStack(spacing: 8) {
                Text(verificationCode.count >= 6 ? verificationCode[5] : " ")
                    .font(.custom("Duplet-SemiBold", size: 22))
                Capsule()
                    .foregroundColor(.gray)
                    .frame(width: (UIScreen.main.bounds.width - 115) / 6, height: 2)
            }
        }
        .background {
            TextField("", text: $verificationCode)
                .frame(width: 1, height: 1)
                .opacity(0.001)
                .blendMode(.screen)
                .focused($isOTPFeildFocused)
                .keyboardType(.numberPad)
        }
        .onAppear {
            isOTPFeildFocused = true
        }
        .onChange(of: verificationCode) { newValue in
            limitVerificationCode(newValue: newValue)
        }
    }
    
    //MARK: function to limmit the otp string to 6 digits
    private func limitVerificationCode(newValue: String) {
        self.verificationCode = String(newValue.prefix(6))
    }
}
