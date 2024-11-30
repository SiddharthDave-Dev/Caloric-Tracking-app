//
//  TabView.swift
//  Caloric Tracking app
//
//  Created by Siddharth Dave on 03/10/23.
//

import SwiftUI

struct foodselected: Identifiable {
    var id = UUID()
    var food: String
    var tab: Tab
}

var selectedTab:[foodselected] = [
    foodselected(food: "Breakfast", tab: .Breakfast),
    foodselected(food: "Lunch", tab: .Lunch),
    foodselected(food: "Dinner", tab: .Dinner),
    foodselected(food: "Snacks", tab: .Snacks),
]

enum Tab: String {
    case Breakfast
    case Lunch
    case Dinner
    case Snacks
}

struct TabView: View {
    
    @Binding var itemSelected: Tab
    var body: some View {
        HStack(spacing: 30) {
            ForEach(selectedTab) { item in
                Button(action: {
                    withAnimation{
                        itemSelected = item.tab
                    }
                }, label: {
                    Text(item.food)
                        .foregroundColor(itemSelected == item.tab ? .white : .black)
                        .padding(8)
                        .background(itemSelected == item.tab ? .black : Color(.clear))
                        .cornerRadius(10)
                })
                
            }
        }
    }
}

#Preview {
    TabView(itemSelected: .constant(.Breakfast))
}
