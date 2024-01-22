//
//  SettingScreen.swift
//  AdvancedMap
//
//  Created by Cain Luo on 2024/1/22.
//

import SwiftUI

struct SettingScreen: View {
    @State var isOn = false
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Toggle(isOn: $isOn, label: {
                        Text("Is Subscribre")
                    })
                    
                    Toggle(isOn: $isOn, label: {
                        Text("Is Subscribre")
                    })

                    Toggle(isOn: $isOn, label: {
                        Text("Is Subscribre")
                    })
                }
                
                Spacer()
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingScreen()
}
