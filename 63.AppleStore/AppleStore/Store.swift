//
//  Store.swift
//  AppleStore
//
//  Created by Cain Luo on 2024/2/4.
//

import SwiftUI
import StoreKit // StoreKit 2

class ViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var purchasedIds: [String] = []

    func fetchProducts() {
        async {
            do {
                let products = try await Product.products(for: ["com.apple.watch"])
                DispatchQueue.main.async {
                    self.products = products
                }
                
                if let product = products.first {
                    await isPurchased(product: product)
                }
            } catch {
                print(error)
            }
        }
    }
    
    func isPurchased(product: Product) async {
        guard let state = await product.currentEntitlement else {
            return
        }
        
        switch state {
        case .unverified(_, _):
            break
        case .verified(let signedType):
            DispatchQueue.main.async {
                self.purchasedIds.append(signedType.productID)
            }
        }
    }
    
    func purchase() {
        async {
            guard let product = products.first else {
                return
            }
            
            do {
                let result = try await product.purchase()
                switch result {
                case .success(let verificationResult):
                    switch verificationResult {
                    case .unverified(_, _):
                        break
                    case .verified(let signedType):
                        purchasedIds.append(signedType.productID)
                    }
                case .userCancelled:
                    break
                case .pending:
                    break
                @unknown default:
                    break
                }
            } catch {
                print(error)
            }
        }
    }
}
