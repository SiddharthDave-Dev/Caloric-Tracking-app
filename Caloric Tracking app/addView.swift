//
//  addView.swift
//  Caloric Tracking app
//
//  Created by Siddharth Dave on 03/10/23.
//

import SwiftUI

struct male:Identifiable{
    var id = UUID()
    var image: String
}
var icons:[male] = [
    male(image:"m1"),
    male(image:"m2"),
    male(image:"m3"),
    male(image:"m4"),
    male(image:"m5"),
    male(image:"m6"),
    male(image:"m7"),
    male(image:"m8"),
]
struct addView: View {
    @Environment(\.presentationMode) var envi
    @EnvironmentObject var vm: CDDataModel
    @State var itemSelected:Tab = .Breakfast
    @State var showicons:Bool = false
    @State var icon:String = "plus2"
    @State var name:String = ""
    @State var title:String = ""
    @State var fat:String = "0"
    @State var protein:String = "0"
    @State var cards:String = "0"
    @State var fatTF:Bool = false
    @State var proteinTF:Bool = false
    @State var cardsTF:Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            TabView(itemSelected: $itemSelected)
            VStack(spacing: 25) {
                Image(icon)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
//                                    .foregroundColor(.gray)
                    .clipShape(Circle())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onTapGesture {
                        showicons.toggle()
                    }
                if showicons {
                    ScrollView(.horizontal,showsIndicators: false) {
                        
                        HStack {
                            ForEach(icons) { item in
                                Image(item.image)
                                    .resizable()
                                    .scaledToFill()
                                .frame(width: 50, height: 50)
                                .onTapGesture {
                                    icon = item.image
                                    withAnimation {
                                        showicons.toggle()
                                    }
                                }
                            }
                        }
                        
                        
                    }
                }
                
                VStack {
                    TextField("name",text:$name)
                    Divider()
                    TextField("title",text: $title)
                }
                .font(.title3)
                .padding()
                .background(.white)
                .cornerRadius(10)
                .modifier(customShadow())
                VStack{
                    values(number: $fat, show: $fatTF, name: "Fat")
                    
                    values(number: $protein, show: $proteinTF, name: "Protein")
                    
                    values(number: $cards, show: $cardsTF, name: "Cards")
                }
                .padding()
                .background(.white)
                .cornerRadius(20)
                .modifier(customShadow())
                Button(action: {
                    switch itemSelected {
                    case .Breakfast:
                        vm.addBreakfast(icon: icon, name: name, ingredients: title, fat: CGFloat(Int(fat) ?? 0), protein: CGFloat(Int(protein) ?? 0), cards: CGFloat(Int(cards) ?? 0))
                        envi.wrappedValue.dismiss()
                    case .Lunch:
                        vm.addLunch(icon: icon, name: name, ingredients: title, fat: CGFloat(Int(fat) ?? 0), protein: CGFloat(Int(protein) ?? 0), cards: CGFloat(Int(cards) ?? 0))
                        envi.wrappedValue.dismiss()
                    case .Dinner:
                        print("Dinner")
                    case .Snacks:
                        print("Snacks")
                    }
                }, label: {
                    Text("Save").bold()
                        .font(.title2)
                        .foregroundColor(.black)
                        .frame(width: 180, height: 50)
                        .background(.white)
                        .cornerRadius(10)
                        .modifier(customShadow())
                        
                })
            }
            .padding()
            Spacer()
        }
        .overlay(alignment: .topTrailing, content: {
            Button {
                envi.wrappedValue.dismiss()
            } label: {
                ZStack {
                    Circle()
                        .frame(width: 30,height: 30)
                        .foregroundColor(.black)
                    
                    Image(systemName: "xmark")
                        .imageScale(.large)
                        .foregroundColor(.white)
                }
                .modifier(customShadow())
                .padding()
            }

        })
    }
}

#Preview {
    addView()
        .environmentObject(CDDataModel())
}

struct values: View {
    @Binding var number:String
    @Binding var show:Bool
    var name = ""
    var body: some View {
        HStack {
            Text(name).bold()
                .font(.title2)
            Spacer()
            Text("\(number)").bold()
                .font(.title2)
                .frame(width: 45, height: 30)
                .background(.black)
                .cornerRadius(5)
                .foregroundColor(.white)
                .onTapGesture {
                    withAnimation {
                        show.toggle()
                    }
                    
                }
            if show {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 5) {
                        ForEach(1 ..< 100) { item in
                            Text("\(item)")
                                .bold()
                                .frame(width: 30, height: 30)
                                .background(.black.opacity(0.2))
                            .cornerRadius(5)
                            .onTapGesture {
                                withAnimation {
                                    show.toggle()
                                    number = "\(item)"
                                }
                                
                            }
                        }
                    }
                }
                .frame(width: 180, height: 30)
            }
        }
        .padding(5)
    }
}
