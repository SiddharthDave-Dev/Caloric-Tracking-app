//
//  ContentView.swift
//  Caloric Tracking app
//
//  Created by Siddharth Dave on 03/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var vm :CDDataModel
    @State var itemselected:Tab = .Breakfast
    @State var show = false
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Hi Sucodee")
                        .bold()
                        .font(.system(size: 35))
                    Spacer()
                    Image("hamburger")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40,height: 40)
//                        .shadow(color: .blue,radius: 20,x: 0,y: 0)
                        .clipShape(Rectangle())
                }
                .padding(.horizontal)
                RingView()
                Divider()
                
                TabView(itemSelected: $itemselected)
                Divider()
                if itemselected == .Breakfast {
                    ScrollView(.horizontal,showsIndicators: false) {
                        HStack(spacing:10) {
                            ForEach(vm.saveBreakfastEntity) { item in
                                
                                foodCard(cards: CGFloat(item.cards), fat: CGFloat(item.fat), protein: CGFloat(item.protein), name: item.name ?? "", title: item.ingredients ?? "", icon: item.icon ?? "")
                                
                                    .padding(.leading)
                                    .overlay(alignment: .topTrailing) {
                                        Button {
                                            vm.addValue(fat: CGFloat(item.fat), protein: CGFloat(item.protein), cards: CGFloat(item.cards))
                                            vm.addmealToggleforBreakfast(meal: item)
                                            vm.Addringcarlories(carlories:  CGFloat(item.cards))
                                        } label: {
                                            ZStack {
                                                Circle()
                                                    .frame(width: 30, height: 30)
                                                    .foregroundColor(.white)
                                                
                                                Image(systemName: item.addmale ? "checkmark" : "plus")
                                                    .imageScale(.small)
                                                    .foregroundColor(.black)
                                            }
                                            .modifier(customShadow())
                                        }
                                        .offset(x:-5,y:5)
                                    }
                            }
                        }
                        .frame(height: 180)
                    }
                    .offset(y: -30)
                } else if itemselected == .Lunch {
                    ScrollView(.horizontal,showsIndicators: false) {
                        HStack(spacing:10) {
                            Text("Coming Soon....")
                                .bold()
                                .font(.title)
//                            ForEach(vm.saveLunchEntity) { item in
//                                
//                                foodCard(cards: CGFloat(item.cards), fat: CGFloat(item.fat), protein: CGFloat(item.protein), name: item.name ?? "", title: item.ingredients ?? "", icon: item.icon ?? "")
//                                
//                                    .padding(.leading)
//                                    .overlay(alignment: .topTrailing) {
//                                        Button {
//                                            vm.addValue(fat: CGFloat(item.fat), protein: CGFloat(item.protein), cards: CGFloat(item.cards))
//                                            vm.addmealToggleForLunch(meal: item)
//                                            vm.Addringcarlories(carlories:  CGFloat(item.cards))
//                                        } label: {
//                                            ZStack {
//                                                Circle()
//                                                    .frame(width: 30, height: 30)
//                                                    .foregroundColor(.white)
//                                                
//                                                Image(systemName: item.addmale ? "checkmark" : "plus")
//                                                    .imageScale(.small)
//                                                    .foregroundColor(.black)
//                                            }
//                                            .modifier(customShadow())
//                                        }
//                                        .offset(x:-5,y:5)
//                                    }
//                            }
                        }
                        .frame(height: 180)
                    }
                } else if itemselected == .Dinner {
                    ScrollView(.horizontal,showsIndicators: false) {
                        HStack(spacing:10) {
                            Text("Coming Soon....")
                                .bold()
                                .font(.title)
                        }
                        .frame(height: 180)
                    }
                } else if itemselected == .Snacks {
                    ScrollView(.horizontal,showsIndicators: false) {
                        HStack(spacing:10) {
                            Text("Coming Soon....")
                                .bold()
                                .font(.title)
                        }
                        .frame(height: 180)
                    }
                }
                
                
                WaterView()
                    .offset(y: -60)
                Spacer()
                    .overlay(alignment: .bottomLeading) {
                        Button(action: {
                            show.toggle()
                        }, label: {
                            Text("New Meal").bold()
                                .foregroundColor(.black)
                                .frame(width: 200, height: 100)
                                .background(.white)
                                .clipShape(Circle())
                                .modifier(customShadow())
                        })
                        .padding()
                    }
                    .sheet(isPresented: $show, content: {
                        addView()
                    })
                    .overlay(alignment: .bottomTrailing) {
                        Button(action: {
                           
                            vm.saveValueEntity.first?.cards = 0
                            vm.saveValueEntity.first?.fat = 0
                            vm.saveValueEntity.first?.protein = 0
                           
                        }, label: {
                            Text("Reset").bold()
                                .foregroundColor(.black)
                                .frame(width: 200, height: 100)
                                .background(.white)
                                .clipShape(Circle())
                                .modifier(customShadow())
                        })
                        .padding()
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
