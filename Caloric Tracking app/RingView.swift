//
//  RingView.swift
//  Caloric Tracking app
//
//  Created by Siddharth Dave on 03/10/23.
//

import SwiftUI

struct customShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.2), radius: 20, x: 0,y: 0)
    }
}

struct RingView: View {
    @EnvironmentObject var vm: CDDataModel
    var percent: CGFloat = 50
    let width: CGFloat = 130
    let height: CGFloat = 130
    
    
    
    var body: some View {
        let ringValue = vm.saveValueEntity.first

        let multiplier = width / 44
        var progress: CGFloat = 0
        if let ringValue = ringValue {
            let sum = ringValue.cards + ringValue.fat + ringValue.protein
            let divisor: CGFloat = 2000
            
            progress = 1 - (CGFloat(sum) / divisor)
            
//            print(progress)
        }
        return  HStack(spacing: 40) {
            ZStack {
                Circle()
                    .stroke(Color.blue.opacity(0.1),style: StrokeStyle(lineWidth: 4 * multiplier))
                    .frame(width: width, height: height)
                Circle()
                    .trim(from: CGFloat(progress),to: 1)
                    .stroke(LinearGradient(gradient: Gradient(colors: [Color("cards"),.blue]), startPoint: .top, endPoint: .bottom),style: StrokeStyle(lineWidth: 5 * multiplier, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20,0], dashPhase: 0))
                    .rotationEffect(Angle(degrees: 90))
                    .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                    .frame(width: width, height: height)
                
                ForEach(vm.saveValueEntity) { item in
                    if progress == 1 {
                        Text("0.0")
                            .bold()
                            .font(.title)
                    } else {
                        Text(String(CGFloat(item.cards) + CGFloat(item.protein) + CGFloat(item.fat)))
                            .bold()
                            .font(.title)
                    }
                    
                }
            }
            
            HStack(spacing: 30) {
                ForEach(vm.saveValueEntity) { item in
                    foodElementvalue(element: "Cards", gram: String(format: "%.0f", item.cards), color: "cards", elementvalue: CGFloat(item.cards))
                    
                    foodElementvalue(element: "fat", gram: String(format: "%.0f", item.fat), color: "fat", elementvalue: CGFloat(item.fat))
                    
                    foodElementvalue(element: "protein", gram: String(format: "%.0f", item.protein), color: "protein", elementvalue: CGFloat(item.protein))
                    
                    
                        
                }
            }
            
        }
        .frame(height: 180)
        .frame(width: UIScreen.main.bounds.width - 20)
        .background(Color.white)
        .cornerRadius(20)
        .modifier(customShadow())
    }
}

#Preview {
    RingView()
        .environmentObject(CDDataModel())
}

struct foodElementvalue:View {
    
    var element = ""
    var gram = ""
    var color = ""
    var elementvalue:CGFloat = 0
    
    var body: some View {
        let height:CGFloat = 130
        let muliplier = height / 2000
        VStack {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .frame(width: 8,height: 110)
                    .foregroundColor(.gray.opacity(0.5))
                
                if elementvalue != 0 {
                    Rectangle()
                        .frame(width: 8,height: elementvalue * muliplier)
                        .foregroundColor(Color(color))
                } else {
                    Rectangle()
                        .frame(width: 8,height: 110)
                        .foregroundColor(Color(color))
                }
            }
            .cornerRadius(10)
            Text(element)
                .font(.system(size: 12))
            Text(gram)
                .font(.system(size: 10))
        }
    }
}
