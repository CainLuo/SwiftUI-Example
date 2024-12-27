//
//  ContentView.swift
//  SwiftUI-TextFieldMenuActions
//
//  Created by Cain on 2024/11/7.
//

import SwiftUI

struct ContentView: View {
    @State private var message: String = ""
    @State private var selection: TextSelection?
    var body: some View {
        NavigationStack {
            List {
                Section("TextField") {
                    /// 10.Sometimes, we have a text field with an axis property. In such cases, as you can see, the custom actions is not visible. This is because when using the axis property in a text field, it transforms the text field into a UITextView instead. Let me demonstrate this for you.
                    TextField("Message", text: $message, selection: $selection)
                        /// 5.Now that we've successfully found the SwiftUI wrapper for the TextField, which essentially contains a UITextField, we can easily extract it using the subviews property.
                        .menu(showSuggestions: true) {
                            /// 7.Let's now create some custom actions for our text field!
                            TextFieldAction(title: "Uppercased") { _, textField in
                                if let selectionRange = textField.selectedTextRange,
                                   let selectedText = textField.text(in: selectionRange) {
                                    let upperCasedText = selectedText.uppercased()
                                    /// 8.As you can see, when modifying the text, the selection disappears. Since I passed the textfield reference to every action, we can use it to customize its behavior.
                                    textField.replace(selectionRange, withText: upperCasedText)
                                    
                                    textField.selectedTextRange = selectionRange
                                }
                            }
                            
                            TextFieldAction(title: "Lowercased") { _, textField in
                                if let selectionRange = textField.selectedTextRange,
                                   let selectedText = textField.text(in: selectionRange) {
                                    let lowerCasedText = selectedText.lowercased()
                                    textField.replace(selectionRange, withText: lowerCasedText)
                                    
                                    textField.selectedTextRange = selectionRange
                                }
                            }
                            
                            /// 9.Now, let me demonstrate an example of replacing a selected text with another one.
                            TextFieldAction(title: "Replace") { range, textField in
                                if let selectionRange = textField.selectedTextRange {
                                    let replacementText = "Hello World!"
                                    
                                    textField.replace(selectionRange, withText: replacementText)

                                    if let start = textField.position(from: selectionRange.start, offset: 0),
                                       let end = textField.position(from: selectionRange.start, offset: replacementText.count) {
                                        textField.selectedTextRange = textField.textRange(from: start, to: end)
                                    }
                                }
                            }
                        }
                }
                
                Section {
//                    Text(message)
                    
                    /// 12.Okay, iOS 18 has introduced the textSelection API for text fields. As you can see, it's not working anymore because we've removed the delegate methods. This can be easily fixed by following this simple step.
                    if let selection, !selection.isInsertion {
                        Text("Some Text is Selected")
                    }
                }
            }
            .navigationTitle("Custom TextField Menu")
        }
    }
}

#Preview {
    ContentView()
}
