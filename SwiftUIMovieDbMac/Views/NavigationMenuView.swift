//
//  NavigationMenuView.swift
//  SwiftUIMovieDbMac
//
//  Created by Alfian Losari on 22/06/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct NavigationMenuView: View {
    
    @ObservedObject var searchState = MovieSearchState()
    @State var selection: String? = "Home"
    
    // Remove Focus on Search Field when selected
    private let cellProxy = ListCellProxy()
    
    var body: some View {
        List(selection: $selection) {
            NavigationLink(destination: MovieSearchView().environmentObject(self.searchState), tag: "Search", selection: self.$selection) {
                SearchFieldView(text: self.$searchState.query, onFocusChange: { focus in
                    if focus {
                        self.selection = "Search"
                    }
                })            }
//                .background(ListCellHelper(proxy: ListCellProxy()))
                .padding(.vertical)
            
            Section(header: Text("Discover")) {
                NavigationLink(destination: HomeView(), tag: "Home", selection: self.$selection) {
                    Text("Home")
                }
            }.collapsible(false)
            
            Section(header: Text("Browse")) {
                ForEach(MovieListEndpoint.allCases) { endpoint in
                    NavigationLink(destination: NavigationDetailView(endpoint: endpoint), tag: endpoint.rawValue, selection: self.$selection) {
                        Text(endpoint.description)
                    }
                }
            }
            .collapsible(false)
        }
        .listStyle(SidebarListStyle())
        .frame(minWidth: 200, idealWidth: 200, maxWidth: 248, maxHeight: .infinity)
        
    }
}

struct NavigationMenuView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationMenuView()
    }
}
