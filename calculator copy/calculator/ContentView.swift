//
//  ContentView.swift
//  calculator
//
//  Created by Alexandru Gurușciuc on 04.12.2023.
//

import SwiftUI

enum CalcButtons:String{
    case one="1"
    case two="2"
    case three="3"
    case four="4"
    case five="5"
    case six="6"
    case seven="7"
    case eight="8"
    case nine="9"
    case zero="0"
    case add="+"
    case substract="-"
    case devide="/"
    case multiply="*"
    case clear="AC"
    case decimal="."
    case percent="%"
    case negative="-/+"
    case equal="="
    
    var buttonColor: Color{
        switch self{
        case .add, .devide, .substract, .equal, .multiply:
            return .blue
        case .clear, .negative, .percent :
            return Color(.lightGray)
        default:
            return Color(.darkGray)
        }
    }
}
 enum Operation{
     case add
     case substract
     case devide
     case multiply
     case none
}

struct ContentView: View {
    
    @State var value = "0"
    @State var runningNumber: Double = 0
    @State var currentOperation: Operation = .none
    
    let buttons :[[CalcButtons]]=[
        [.clear, .negative, .percent, .devide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .substract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                //Afisarea textului
                HStack{
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 72))
                        .foregroundColor(.white)
                }
                .padding()
                //Pentru butoane
                ForEach(buttons, id: \.self){ row in
                    HStack{
                        ForEach(row, id: \.self){ item in
                            Button(action: {
                                self.didTap(button: item)
                                
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 36))
                                    .frame(
                                        width:self.buttonWidth(item: item),
                                        height:self.buttonHeight()
                                    )
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                            })
                        }
                    }
                    .padding(.bottom,3)
                }
            }
        }
    }
    func didTap(button:CalcButtons){
        switch button{
        case .add, .substract, .devide, .multiply, .equal:
            if button == .add{
                self.currentOperation = .add
                self.runningNumber = Double(self.value) ?? 0
            }
            else if button == .substract{
                self.currentOperation = .substract
                self.runningNumber = Double(self.value) ?? 0
            }
            else if button == .devide{
                self.currentOperation = .devide
                self.runningNumber = Double(self.value) ?? 0
            }
            else if button == .multiply{
                self.currentOperation = .multiply
                self.runningNumber = Double(self.value) ?? 0
            }
            else if button == .equal{
                let runningValue = self.runningNumber
                let currentValue = Double(self.value) ?? 0
                switch self.currentOperation{
                case .add: self.value = "\(runningValue + currentValue)"
                case .substract: self.value = "\(runningValue - currentValue)"
                case .devide: self.value = "\(runningValue / currentValue)"
                case .multiply: self.value = "\(runningValue * currentValue)"
                case.none:
                    break
                }
            }
            if button != .equal{
                self.value = "0"
            }
        case .clear:
            self.value = "0"
        case .negative:self.value = "\((Double(self.value) ?? 0) * -1)"
        case .decimal:
            if !value.contains(".") {
                        value += "."
                    }
        case .percent:
                if let currentValue = Double(value) {
                    let percentageValue = currentValue / 100.0
                    value = "\(percentageValue)"
                }
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            }
            else{
                self.value = "\(self.value)\(number)"
            }
        }

    }
    func buttonWidth(item:CalcButtons) ->CGFloat{
        if item == .zero{
            return((UIScreen.main.bounds.width - (4*12)) / 4) * 2
        }
        return(UIScreen.main.bounds.width - (5*12)) / 4
    }
    func buttonHeight() ->CGFloat{
        return(UIScreen.main.bounds.width - (5*12)) / 4
    }
}

#Preview {
    ContentView()
}
