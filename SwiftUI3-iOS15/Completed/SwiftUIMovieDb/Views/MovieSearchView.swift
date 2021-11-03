//
//  MovieSearchView.swift
//  SwiftUIMovieDb
//
//  Created by Alfian Losari on 24/05/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct MovieSearchView: View {
    
    @StateObject var movieSearchState = MovieSearchState()
    
    var body: some View {
        List {
            ForEach(movieSearchState.movies) { movie in
                NavigationLink(destination: MovieDetailView(movieId: movie.id, movieTitle: movie.title)) {
                    MovieRowView(movie: movie).padding(.vertical, 8)
                }
            }
        }
        .searchable(text: $movieSearchState.query, prompt: "Search movies")
        .overlay(overlayView)
        .onAppear { movieSearchState.startObserve() }
        .listStyle(.plain)
        .navigationTitle("Search")
    }
    
    @ViewBuilder
    private var overlayView: some View {
        switch movieSearchState.phase {
            
        case .empty:
            if movieSearchState.trimmedQuery.isEmpty {
                EmptyPlaceholderView(text: "Search your favorite movie", image: Image(systemName: "magnifyingglass"))
            } else {
                ProgressView()
            }
            
        case .success(let values) where values.isEmpty:
            EmptyPlaceholderView(text: "No results", image: Image(systemName: "film"))
            
        case .failure(let error):
            RetryView(text: error.localizedDescription, retryAction: {
                Task {
                    await movieSearchState.search(query: movieSearchState.query)
                }
            })
            
        default: EmptyView()
        }
    }
    
}

struct MovieRowView: View {
    
    let movie: Movie
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            MovieThumbnailView(movie: movie, thumbnailType: .poster(showTitle: false))
                .frame(width: 61, height: 92)
            
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)
                
                Text(movie.yearText)
                    .font(.subheadline)
                
                Spacer()
                
                Text(movie.ratingText)
                    .foregroundColor(.yellow)
            }
        }
    }
}


struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MovieSearchView()
        }
    }
}
