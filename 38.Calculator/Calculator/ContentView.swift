//
//  ContentView.swift
//  Calculator
//
//  Created by Cain Luo on 2024/1/23.
//

import SwiftUI

enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "/"
    case muliply = "x"
    case equeal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .muliply, .divide, .equeal:
            return .orange
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55 / 255.0, green: 55 / 255.0,
                                 blue: 55 / 255.0, alpha: 1))
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
}

struct ContentView: View {
    
    @State var value = "0"
    @State var runningNumber = 0
    @State var currentOperation: Operation = .none
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .muliply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equeal]
    ]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                // Text display
                HStack {
                    Spacer()
                    
                    Text(value)
                        .bold()
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                }
                .padding()
                
                // Our buttons
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                didTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 32))
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight()
                                    )
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item) / 2)
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
    
    func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .divide, .muliply, .equeal:
            if button == .add {
                currentOperation = .add
                runningNumber = Int(value) ?? 0
            } else if button == .subtract {
                currentOperation = .subtract
                runningNumber = Int(value) ?? 0
            } else if button == .divide {
                currentOperation = .divide
                runningNumber = Int(value) ?? 0
            } else if button == .muliply {
                currentOperation = .multiply
                runningNumber = Int(value) ?? 0
            } else if button == .equeal {
                let currentValue = Int(value) ?? 0
                switch currentOperation {
                case .add: self.value = "\(runningNumber + currentValue)"
                case .subtract: self.value = "\(runningNumber - currentValue)"
                case .multiply: self.value = "\(runningNumber * currentValue)"
                case .divide: self.value = "\(runningNumber / currentValue)"
                case .none:
                    break
                }
            }
            if button != .equeal {
                self.value = "0"
            }
        case .clear:
            self.value = "0"
        case .decimal, .percent, .negative:
            break
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            } else {
                self.value = "\(self.value)\(number)"
            }
        }
    }
    
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4 * 12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    
    func buttonHeight() -> CGFloat {
        (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
}

#Preview {
    ContentView()
}
