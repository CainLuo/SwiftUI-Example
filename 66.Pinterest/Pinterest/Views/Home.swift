//
//  Home.swift
//  Pinterest
//
//  Created by Cain Luo on 2024/2/4.
//

import SwiftUI
import SDWebImageSwiftUI

struct Home: View {
    // Getting Window Size....
    var window = NSScreen.main?.visibleFrame ?? .zero
    
    @State var search: String = ""
    @StateObject var viewModel = ImageViewModel()
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 15),
                        count: 4)
    
    var body: some View {
        HStack {
            SideBar()
            
            VStack {
                HStack(spacing: 12) {
                    // Search Bar
                    
                    HStack(spacing: 15) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search", text: $search)
                            .textFieldStyle(PlainTextFieldStyle())
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(BlurWindow())
                    .cornerRadius(10)
                    
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "slider.vertical.3")
                            .foregroundColor(.black)
                            .padding(10)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.1),
                                    radius: 5, x: 5, y: 5)
                            .shadow(color: Color.black.opacity(0.1),
                                    radius: 5, x: -5, y: -5)
                    })
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.black)
                            .cornerRadius(10)
                    })
                    .buttonStyle(PlainButtonStyle())
                }
                
                // ScrollView With Images....
                
                GeometryReader { reader in
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 15) {
                            // Getting Images...
                            
                            ForEach(viewModel.images.indices, id: \.self) { index in
                                
                                ZStack {
                                    WebImage(url: URL(string: viewModel.images[index].download_url))
                                        .placeholder(content: {
                                            ProgressView()
                                        })
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: (reader.frame(in: .global).width - 45) / 4,
                                               height: 150)
                                        .cornerRadius(15)
                                                                        
                                    Color.black.opacity(viewModel.images[index].onHover ?? false ? 0.2 : 0)
                                        .cornerRadius(15)
                                        
                                    VStack {
                                        HStack {
                                            Spacer(minLength: 0)
                                            
                                            Button {
                                                print("AAAAAAAA")
                                            } label: {
                                                Image(systemName: "hand.thumbsup.fill")
                                                    .foregroundColor(.yellow)
                                                    .padding(8)
                                                    .background(Color.white)
                                                    .cornerRadius(10)
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                            
                                            Button {
                                                print("BBBBBBBBB")
                                                saveImage(index: index)
                                            } label: {
                                                Image(systemName: "folder.fill")
                                                    .foregroundColor(.blue)
                                                    .padding(8)
                                                    .background(Color.white)
                                                    .cornerRadius(10)
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                        }
                                        .padding(10)
                                        
                                        Spacer()
                                    }
                                    .opacity(viewModel.images[index].onHover ?? false ? 1 : 0)
                                }
                                // Hover...
                                .onHover { hovering in
                                    withAnimation {
                                        viewModel.images[index].onHover = hovering
                                    }
                                }
                            }
                        }
                        .padding(.vertical)
                    }
                }
                
                Spacer()
            }
            .padding()
        }
        .frame(width: window.width / 1.5,
               height: window.height - 40)
        .background(Color.white.opacity(0.6))
        .background(BlurWindow())
    }
    
    func saveImage(index: Int) {
        
        // getting Image data Form URL...
        let manager = SDWebImageDownloader(config: .default)
        manager.downloadImage(with: URL(string: viewModel.images[index].download_url)!) { image, _, _, _  in
            guard let imageOriginal = image else { return }
            let data = imageOriginal.sd_imageData(as: .JPEG)
            
            // Saveing Image...
            let pannel = NSSavePanel()
            pannel.canCreateDirectories = true
            pannel.nameFieldStringValue = "\(viewModel.images[index].id).jpg"
            pannel.begin { response in
                if response.rawValue == NSApplication.ModalResponse.OK.rawValue {
                    // saving Image
                    do {
                        try data?.write(to: pannel.url!, options: .atomic)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

#Preview {
    Home()
}

struct SideBar: View {
    
    @State var selected = "Home"
    @Namespace var animation
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(spacing: 22) {
                Group {
                    HStack {
                        Image(systemName: "applelogo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 45, height: 45)
                        
                        Text("Pinterst")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        
                        Spacer(minLength: 0)
                    }
                    .padding(.top, 35)
                    .padding(.leading, 10)
                    
                    // Tab Button
                    
                    TabButton(image: "house.fill",
                              title: "Home",
                              animation: animation,
                              selected: $selected)
                    
                    TabButton(image: "clock.fill",
                              title: "Recents",
                              animation: animation,
                              selected: $selected)
                    
                    TabButton(image: "person.2.fill",
                              title: "Following",
                              animation: animation,
                              selected: $selected)
                    
                    HStack {
                        Text("Insights")
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                        
                        Spacer()
                    }
                    .padding()
                    
                    TabButton(image: "message.fill",
                              title: "Messages",
                              animation: animation,
                              selected: $selected)
                    
                    TabButton(image: "bell.fill",
                              title: "Notifications",
                              animation: animation,
                              selected: $selected)
                }
                
                Spacer(minLength: 0)
                
                VStack(spacing: 8) {
                    Image(systemName: "bus.doubledecker")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.pink)
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Unlock Business Tools")
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                    })
                    .buttonStyle(PlainButtonStyle())
                    
                    Text("Hurry! Up Now you can unlock our new business tools at your convinence")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                }
                
                Spacer(minLength: 0)
                
                // Profile View....
                
                HStack(spacing: 10) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Justine")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        
                        Text("Last Login 06")
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer(minLength: 0)
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 8)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1),
                        radius: 5, x: 5, y: 5)
                .shadow(color: Color.black.opacity(0.1),
                        radius: 5, x: -5, y: -5)
                .padding(.horizontal)
                .padding(.bottom)
            }
            
            Divider()
                .offset(x: -2)
        }
        // Side Bar Default Size...
        .frame(width: 240)
    }
}

// Hiding Focus Ring...
extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get { .none }
        set { }
    }
}
