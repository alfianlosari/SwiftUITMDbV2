//
//  MovieSearchView.swift
//  SwiftUIMovieDbMac
//
//  Created by Alfian Losari on 21/06/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct MovieSearchView: View {
    
    @EnvironmentObject var searchState: MovieSearchState
    
    @State var selection: Movie?
    
    var body: some View {
        HStack(spacing: 0) {
            Group {
                if !self.searchState.isLoading && (self.searchState.query == "" || self.searchState.isEmptyResults) {
                    VStack(spacing: 8) {
                        Text(self.searchState.isEmptyResults ? "No Results" : "Search Movies")
                            .font(.headline)
                        Text( self.searchState.isEmptyResults ? "Movies not found for text \"\(self.searchState.query)\"" : "Please type the movie you want to search")
                    }
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if self.searchState.isLoading || self.searchState.error != nil {
                    LoadingView(isLoading: self.searchState.isLoading, error: self.searchState.error) {
                        self.searchState.search(query: self.searchState.query)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else  {
                    List(selection: self.$selection) {
                        if self.searchState.movies != nil {
                            ForEach(self.searchState.movies!) { movie in
                                MovieRowView(movie: movie)
                                    .tag(movie)
                            }
                        }
                    }
                }
            }
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
        .onAppear {
            self.searchState.startObserve()
        }
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
