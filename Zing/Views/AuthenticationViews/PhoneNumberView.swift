//
//  PhoneNumberView.swift
//  Zing
//
//  Created by Adarsh Shukla on 02/02/23.
//

import SwiftUI

struct PhoneNumberView: View {
    
    @State  var countrySelection: Country = Country(rawValue: Locale.current.region?.identifier ?? "") ?? .void
    @State var phoneNumber: String = ""
    @State var first = true
    @FocusState private var isPhoneNumberFieldFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Let’s get started")
                        .font(.custom("Duplet-Bold", size: 30))
                    Spacer()
                }
                .padding(.bottom, 4)
                
                HStack {
                    Text("Enter your mobile number, and we’ll send an SMS to confirm it.")
                        .font(.custom("Mulish-SemiBold", size: 18))
                    Spacer()
                }
                .padding(.bottom, 29)
                
                HStack {
                    Menu {
                        Picker("Select Country", selection: $countrySelection) {
                            ForEach(Country.allCases, id: \.self) { value in
                                Text("\(countryFlag(countryCode: value.abbreviation ?? "")) \(value.name)    +\(countries[value.rawValue] ?? "")")
                                    .tag(value)
                            }
                        }
                        .pickerStyle(.menu)
                    } label: {
                        HStack(spacing: 0) {
                            Text("+\(countries[countrySelection.rawValue] ?? "")")
                                .foregroundColor(.black)
                                .font(.custom("Duplet-Bold", size: 22))
                                //.frame(width: 55, alignment: .leading)
                            
                            Image(systemName: "arrowtriangle.down.fill")
                                .resizable()
                                .foregroundColor(.black)
                                .frame(width: 16, height: 8)
                                .padding(.horizontal, 10)
                        }
                    }
                    
                    TextField("12345 12345", text: $phoneNumber)
                        .font(.custom("Duplet-SemiBold", size: 22))
                        .keyboardType(.numberPad)
                        .tracking(2)
                        .focused($isPhoneNumberFieldFocused)
                    //Spacer()
                }
                
                Spacer()
                
                NavigationLink {
                    OTPView()
                } label: {
                    Rectangle()
                        .foregroundColor(phoneNumber.count
                                         != 11 ? Color(hex: "2B2B2B").opacity(0.5) : Color(hex: "2B2B2B"))
                        .frame(height: 50)
                        .overlay(alignment: .center) {
                            Text("Next")
                                .foregroundColor(.white)
                                .font(.custom("Duplet-Bold", size: 20))
                        }
                }

                Rectangle()
                    .foregroundColor(.white)
                    .frame(height: 20)
                
            }
            .onChange(of: self.phoneNumber, perform: { newValue in
                limitPhoneNumberString(newValue: newValue)
                formatPhoneNumberString(newValue: newValue)
            })
            .padding(.horizontal)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "chevron.down")
                        .fontWeight(.semibold)
                }
            }
        }
        .onAppear {
            self.isPhoneNumberFieldFocused = true
        }
    }
    //MARK: function to format the phone number string to show blank space after 5 digits.
    private func formatPhoneNumberString(newValue: String) {
        if newValue.count == 5 && first {
            self.phoneNumber.append(" ")
        }
        else if newValue.count == 6 && !first {
            self.phoneNumber = self.phoneNumber.replacingOccurrences(of: " ", with: "")
        }
        else if newValue.count > 5 {
            self.first = false
        }
        else {
            self.first = true
        }
    }
    
    //MARK: function to limmit the phone number string to 10 digits
    private func limitPhoneNumberString(newValue: String) {
        self.phoneNumber = String(newValue.prefix(11))
    }
}


struct PhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberView()
    }
}
