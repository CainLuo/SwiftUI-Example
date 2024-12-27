//
//  TextFieldActions.swift
//  SwiftUI-TextFieldMenuActions
//
//  Created by Cain on 2024/11/7.
//

import SwiftUI

extension TextField {
    /// 3.If you want dynamic behavior, change this one to Binding one.
    @ViewBuilder
    func menu(showSuggestions: Bool = true, @TextFieldActionBuilder actions: @escaping () -> [TextFieldAction]) -> some View {
        self
            .background(TextFieldActionHelper(showSuggestions: showSuggestions, actions: actions()))
            /// 4.CompositingGroup modifier groups both the background and the TextField in a single view. We can take advantage of this and find the associated TextField by traversing the superview property.
            .compositingGroup()
    }
}

/// 1.By passing the UITextField reference, you can update more than the text in the textField!
struct TextFieldAction {
    var title: String
    var action: (NSRange, UITextField) -> ()
}

/// 2.This result builder enables us to define TextField Actions in a manner similar to defining SwiftUI Views, eliminating the need for arrays, commas, and other such constructs.
@resultBuilder
struct TextFieldActionBuilder {
    static func buildBlock(_ components: TextFieldAction...) -> [TextFieldAction] {
        components.compactMap { $0 }
    }
}

fileprivate struct TextFieldActionHelper: UIViewRepresentable {
    var showSuggestions: Bool
    var actions: [TextFieldAction]
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        
        DispatchQueue.main.async {
            /// 6.Now, with the assistance of this, we can effortlessly modify the menu items for the selected text by invoking its delegate methods.
            if let textField = view.superview?.superview?.subviews.last?.subviews.first as? UITextField {
                context.coordinator.originalDelegate = textField.delegate
                textField.delegate = context.coordinator
            }
            
//            if let textField = view.superview?.superview?.subviews.last?.subviews.first as? UITextView {
//                textField.delegate = context.coordinator
                /// 11.As I mentioned earlier, the text field has been replaced with a UITextView. We can make it work by simply converting the text field delegate methods into text view methods. For more information, refer to the pinned comment.
//                print(textField)
//            }
        }
        
        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: TextFieldActionHelper
        init(parent: TextFieldActionHelper) {
            self.parent = parent
        }
        
        /// 13.You can use this originalDelegate property to keep references to the SwiftUI's default delegate methods for future use.
        var originalDelegate: UITextFieldDelegate?
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            originalDelegate?.textFieldDidChangeSelection?(textField)
        }
        
        func textField(_ textField: UITextField,
                       editMenuForCharactersIn range: NSRange,
                       suggestedActions: [UIMenuElement]
        ) -> UIMenu? {
            var actions: [UIMenuElement] = []
            let customActions = parent.actions.compactMap { item in
                let action = UIAction(title: item.title) { _ in
                    item.action(range, textField)
                }
                return action
            }
            
            if parent.showSuggestions {
                actions = customActions + suggestedActions
            } else {
                actions = customActions
            }
            
            let menu = UIMenu(children: actions)
            
            return menu
        }
    }
}

#Preview {
    ContentView()
}
