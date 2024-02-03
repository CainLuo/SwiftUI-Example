//
//  ContentView.swift
//  PullToRefresh
//
//  Created by Cain Luo on 2024/2/3.
//

import SwiftUI

struct User: Codable {
    let name: String
    let email: String
}

struct UserViewModel: Identifiable {
    var id = UUID().uuidString
    let user: User
}

class UsersViewModel: ObservableObject {
    
    @Published var users = [
        UserViewModel(user: User(name: "Afraz", email: "hello@outlook.com"))
    ]
    
    func refreshUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, 
                    error == nil else {
                return
            }
            
            do {
                let newUsers = try JSONDecoder().decode([User].self, 
                                                        from: data)
                DispatchQueue.main.async {
                    self.users.append(contentsOf: newUsers.compactMap({
                        UserViewModel(user: $0)
                    }))
                }
            } catch {
                print("error: \(error)")
            }
        }
        
        task.resume()
    }
}

struct ContentView: View {
    @ObservedObject var viewModel = UsersViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.users) { item in
                    VStack(alignment: .leading) {
                        Text(item.user.name)
                            .font(.title)
                            .bold()
                        Text(item.user.email)
                            .font(.body)
                    }
                }
                .refreshable {
                    self.viewModel.refreshUsers()
                }
            }
            .navigationTitle("Friend List")
        }
    }
}

#Preview {
    ContentView()
}
