//
//  ContentView.swift
//  FormsAndTextFiled
//
//  Created by Cain Luo on 2024/1/14.
//

import SwiftUI

class FormViewModel: ObservableObject {
    
    @State var firstName: String = ""
    @State var lastName: String = ""

    @State var password: String = ""
    @State var passwordAgain: String = ""
    
    @State var streetAddress: String = ""
    @State var city: String = ""
    @State var state: String = ""
    @State var postalCode: String = ""
    @State var country: String = ""
}

struct ContentView: View {

    @StateObject var viewModel = FormViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("First Name", text: $viewModel.firstName)
                        TextField("Last Name", text: $viewModel.lastName)
                    }
                    
                    Section(footer: Text("Your password must be at last 8 characters long.")) {
                        SecureField("Create Password", text: $viewModel.password)
                        SecureField("Confirm Password", text: $viewModel.passwordAgain)
                    }
                    
                    Section(header: Text("Mailing Address")) {
                        TextField("Street Address", text: $viewModel.streetAddress)
                        TextField("City", text: $viewModel.city)
                        TextField("State", text: $viewModel.state)
                        TextField("Postal Code", text: $viewModel.postalCode)
                        TextField("Country", text: $viewModel.country)

                    }
                }
                
                Button(action: {
                    // Do some thing
                }, label: {
                    Text("Continue")
                        .frame(width: 250,
                               height: 50,
                               alignment: .center)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                })
                .padding()
            }
            .navigationTitle("Create Account")
        }
    }
}

#Preview {
    ContentView()
}
