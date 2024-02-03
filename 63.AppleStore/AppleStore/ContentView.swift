//
//  ContentView.swift
//  AppleStore
//
//  Created by Cain Luo on 2024/2/4.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
        
    var body: some View {
        VStack {
            Image(systemName: "applelogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
            
            Text("Apple Sotre")
                .bold()
                .font(.system(size: 32))
            
            Image(systemName: "applewatch")
                .resizable()
                .frame(width: 150, height: 200)
                .aspectRatio(contentMode: .fit)
            
            if let product = viewModel.products.first {
                Text(product.displayName)
                Text(product.description)
                
                let isPurchased = viewModel.purchasedIds.isEmpty
 
                Button(action: {
                    if isPurchased {
                        viewModel.purchase()
                    }
                }, label: {
                    Text(isPurchased ? "Buy Now: \(product.displayPrice)" : "Purchased")
                        .bold()
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .background(isPurchased ? Color.blue : Color.green)
                        .cornerRadius(8)
                })
                .padding()
            }
        }
        .onAppear {
            viewModel.fetchProducts()
        }
    }
}

#Preview {
    ContentView()
}
