//
//  ContentView.swift
//  DynamicList
//
//  Created by Cain Luo on 2024/1/23.
//

import SwiftUI

struct Stock: Identifiable {
    var id = UUID()
    let title: String
}

class StocksViewModel: ObservableObject {
    @Published var stocks: [Stock] = [
        Stock(title: "Apple"),
        Stock(title: "Google"),
        Stock(title: "Amazong"),
        Stock(title: "MSFT")
    ]
}

struct ContentView: View {
    
    @StateObject var viewModel = StocksViewModel()
    @State var text: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Section(header: Text("Add New Stock")) {
                    TextField("Company Name...", text: $text)
                        .padding()
                    
                    Button(action: {
                        tryToAddToList()
                    }, label: {
                        Text("Add To List")
                            .bold()
                            .frame(width: 250, height: 50)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    })
                    .padding()
                }
                
                List {
                    ForEach(viewModel.stocks) { item in
                        StockRow(title: item.title)
                    }
                }
            }
            .navigationTitle("Stocks")
        }
    }
    
    func tryToAddToList() {
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        viewModel.stocks.append(Stock(title: text))
        text = ""
    }
}

struct StockRow: View {
    let title: String
    
    var body: some View {
        Label(
            title: { Text(title) },
            icon: { Image(systemName: "chart.bar") }
        )
    }
}

#Preview {
    ContentView()
}
