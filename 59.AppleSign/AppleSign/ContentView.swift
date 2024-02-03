//
//  ContentView.swift
//  AppleSign
//
//  Created by Cain Luo on 2024/2/3.
//

import SwiftUI
import AuthenticationServices

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @AppStorage("userId") var userId: String = ""

    private var isSignedIn: Bool {
        !userId.isEmpty
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if !isSignedIn {
                    AppleSignInView()
                } else {
                    Text("Welcome back")
                }
            }
            .navigationTitle("Sign In")
        }
    }
}

struct AppleSignInView: View {
    @Environment(\.colorScheme) var colorScheme

    @AppStorage("email") var email: String = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @AppStorage("userId") var userId: String = ""

    var body: some View {
        SignInWithAppleButton(.continue) { request in
            request.requestedScopes = [.email, .fullName]
        } onCompletion: { result in
            switch result {
            case .success(let auth):
                switch auth.credential {
                case let authAppleCredential as ASAuthorizationAppleIDCredential:
                    
                    // User Id
                    let userId = authAppleCredential.user
                    
                    // User Info
                    let email = authAppleCredential.email
                    let firstName = authAppleCredential.fullName?.givenName
                    let lastName = authAppleCredential.fullName?.familyName
                    
                    self.email = email ?? ""
                    self.firstName = firstName ?? ""
                    self.lastName = lastName ?? ""
                    self.userId = userId
                    
                default:
                    break
                }
            case .failure(let error):
                print(error)
            }
        }
        .signInWithAppleButtonStyle(
            colorScheme == .dark ? .white : .black
        )
        .frame(height: 50)
        .padding()
        .cornerRadius(8)
    }
}

#Preview {
    ContentView()
}
