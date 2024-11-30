//
//  Caloric_Tracking_appApp.swift
//  Caloric Tracking app
//
//  Created by Siddharth Dave on 03/10/23.
//

import SwiftUI

@main
struct Caloric_Tracking_appApp: App {
    @StateObject var vm: CDDataModel = CDDataModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(CDDataModel())
        }
    }
}
