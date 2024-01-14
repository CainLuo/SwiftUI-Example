//
//  ContentView.swift
//  ExampleApp
//
//  Created by Cain Luo on 2024/1/13.
//

import SwiftUI

let mockData: [Data] = [
    Data(title: "Image 1",
         imageName: "img7",
         imageDescription: "This is image 1",
         imageTakenDate: "1/1/2020"),
    Data(title: "Image 2",
         imageName: "img8",
         imageDescription: "This is image 2",
         imageTakenDate: "1/1/2020"),
    Data(title: "Image 3",
         imageName: "img9",
         imageDescription: "This is image 3",
         imageTakenDate: "1/1/2020"),
    Data(title: "Image 4",
         imageName: "img10",
         imageDescription: "This is image 4",
         imageTakenDate: "1/1/2020"),
    Data(title: "Image 5",
         imageName: "img11",
         imageDescription: "This is image 5",
         imageTakenDate: "1/1/2020"),
    Data(title: "Image 6",
         imageName: "img12",
         imageDescription: "This is image 6",
         imageTakenDate: "1/1/2020"),
    Data(title: "Image 7",
         imageName: "img13",
         imageDescription: "This is image 7",
         imageTakenDate: "1/1/2020")
]

struct Data: Identifiable {
    var id = UUID()
    let title: String
    let imageName: String
    let imageDescription: String
    let imageTakenDate: String
}

struct ContentView: View {
    
    var items = [Data]()
    
    var body: some View {
        NavigationView {
            List(items) { item in
                NavigationLink(destination: DataView(data: item)) {
                    Image(item.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100,
                               height: 100,
                               alignment: .center)
                        .background(Color.gray)
                        .cornerRadius(10)
                    Text(item.title)
                        .foregroundColor(.primary)
                        .fontWeight(.bold)
                }
            }
            .navigationTitle("Photos")
        }
    }
}

struct DataView: View {
    
    let data: Data
    
    var body: some View {
        VStack {
            Image(data.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 330,
                       height: 300,
                       alignment: .center)
            Text(data.imageDescription)
                .font(.largeTitle)
            
            Spacer()
            
            Text(data.imageTakenDate)
        }
        .navigationTitle(data.title)
    }
}

#Preview {
    ContentView(items: mockData)
        .environment(\.colorScheme, .dark)
}

#Preview() {
    ContentView(items: mockData)
        .environment(\.colorScheme, .light)
        .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
}
