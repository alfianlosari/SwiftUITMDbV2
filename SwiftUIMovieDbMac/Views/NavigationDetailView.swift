//
//  NavigationDetailView.swift
//  SwiftUIMovieDbMac
//
//  Created by Alfian Losari on 22/06/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct NavigationDetailView: View {
    
    private let movieListState = MovieListState()
    
    let endpoint: MovieListEndpoint
    @State var selection: Movie?
    
    var body: some View {
        HStack(spacing: 0) {
            MovieListView(endpoint: self.endpoint, movieListState: movieListState, selectedMovie: self.$selection)
                .frame(width: 264)
                .frame(maxHeight: .infinity)
            
            Rectangle().fill(Color(NSColor.separatorColor))
                .frame(width: 1)
                .frame(maxHeight: .infinity)
            
            if self.selection != nil {
                MovieDetailView(movie: self.selection!)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(NSColor.controlBackgroundColor))
                
            } else {
                VStack(spacing: 8) {
                    Text("No Movie Selected")
                        .font(.headline)
                    Text("Please select a movie to see details")
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}


struct NavigationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationDetailView(endpoint: .nowPlaying)
    }
}
