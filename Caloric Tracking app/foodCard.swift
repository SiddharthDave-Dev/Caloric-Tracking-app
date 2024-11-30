//
//  foodCard.swift
//  Caloric Tracking app
//
//  Created by Siddharth Dave on 03/10/23.
//

import SwiftUI

struct foodCard: View {
    let width: CGFloat = 200
    @State var cards:CGFloat = 20
    @State var fat:CGFloat = 100
    @State var protein:CGFloat = 70
    @State var name:String = ""
    @State var title:String = ""
    @State var icon:String = ""
    
    var body: some View {
        
        let multiplier = width / 40
        return VStack(alignment: .leading,spacing: 2) {
            HStack {
                Text(name)
                    .font(.title2)
                    .frame(width: 160)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
            .bold()
            HStack {
                Text(title)
                Spacer()
            }
            .frame(width: 200,height: 30)
            .minimumScaleFactor(0.6)
        }
        .offset(x:20,y:-20)
        .frame(width: 270,height: 110)
        .background(.white)
        .cornerRadius(10)
        .modifier(customShadow())
        .overlay(alignment: .topLeading, content: {
            Image(icon)
                .resizable()
                .scaledToFill()
                .frame(width: 65, height: 65)
                .offset(x: -12, y: -16)
        })
        .overlay(alignment: .bottom, content: {
            HStack {
                Element(name: "Cards", foodElemint: cards,multiplier: multiplier, color: "cards")
                
                Element(name: "Fat", foodElemint: protein,multiplier: multiplier, color: "fat")
                
                Element(name: "Proteins", foodElemint: fat,multiplier: multiplier, color: "protein")
            }
        })
        
    }
}

#Preview {
    foodCard()
}

struct Element: View {
    var name = "name"
    var foodElemint: CGFloat = 0
    var multiplier:CGFloat = 0
    var color = ""
    var body: some View {
        let width: CGFloat = 130
        let multiplier = width / 200
        return  VStack{
            Text(name)
                .font(.system(size: 12))
            Rectangle()
                .frame(width: foodElemint * multiplier, height: 5)
                .cornerRadius(5)
                .foregroundColor(Color(color))
        }
        .padding(.bottom,5)
        .frame(width: 90)
    }
}
