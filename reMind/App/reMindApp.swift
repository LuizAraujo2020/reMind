//
//  reMindApp.swift
//  reMind
//
//  Created by Luiz Araujo on 15/02/24.
//

import SwiftUI

@main
struct reMindApp: App {
    @StateObject var boxesVM = BoxesViewModel()
    var body: some Scene {
        WindowGroup {
            BoxesView(viewModel: boxesVM)
        }
    }
}
