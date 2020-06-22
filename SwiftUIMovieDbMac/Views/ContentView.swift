//
//  ContentView.swift
//  SwiftUIMovieDbMac
//
//  Created by Alfian Losari on 20/06/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        RootView()
            .frame(minWidth: 1016, maxWidth: .infinity, minHeight: 556, maxHeight: .infinity)
    }
}

struct RootView: View {
    
    var body: some View {
        NavigationView {
            NavigationMenuView()
            HomeView()
        }.navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


