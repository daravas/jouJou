//
//  QuestionView.swift
//  jouJou
//
//  Created by Alexandra Zarzar on 19/07/21.
//

import SwiftUI

struct QuestionView: View {
    @Binding var titulo: String
    @State  var isShowingQuestion: Bool = true
    @State  var holdingText: String = "Eu diria que..."
    
    @State var text: String = "Clique aqui para adicionar o texto"
    @State private var height2: CGFloat = .zero
    @State private var width2: CGFloat = .zero
    
    init(titulo: Binding<String>){
        self._titulo = titulo
        UITextView.appearance().backgroundColor = .clear
    }
    var body: some View {
        if isShowingQuestion{
            VStack{
                HStack{
                    Text(titulo)
                        .font(Font.custom("Raleway-Regular", size: 24))
                    Spacer()
                    Button(action: {
                        withAnimation{
                            isShowingQuestion = false
                        }
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(Color.blueColor)
                    })
                }
                ZStack (alignment: .topLeading){
                    TextEditor(text: $holdingText)
                        .font(Font.custom("Raleway-Regular", size: 20))
                        .foregroundColor(Color.gray)
                        .padding()
                        .background(Color.lightSalmonColor)
                        .cornerRadius(10)
                        .frame(width: 660, height: height2)
                    
                    Text(holdingText)
                        .font(Font.custom("Raleway-Regular", size: 20))
                        .padding()
                        .multilineTextAlignment(.leading)
                        .background(GeometryReader { /// quaseeee aff
                            Color.clear.preference(key: ViewHeightKey2.self, value: $0.frame(in: .local).size.height)
                        })
                        .opacity(0)
                        .frame(width: 660, alignment: .leading)
                }.onPreferenceChange(ViewHeightKey2.self) { height2 = $0 }
                
            }.frame(width: 660)
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(titulo: .constant("Como tais se sentindo, mana?"))
    }
}
struct ViewHeightKey2: PreferenceKey {
    static var defaultValue: CGFloat { 140 } //quase nada amkigo
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
        print("Reporting height: \(value)")
    }
}
