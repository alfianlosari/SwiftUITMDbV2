//
//  MovieListView.swift
//  SwiftUIMovieDB
//
//  Created by Alfian Losari on 22/05/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct MovieListView: View {
    
    @ObservedObject private var nowPlayingState = MovieListState()
    @ObservedObject private var upcomingState = MovieListState()
    @ObservedObject private var topRatedState = MovieListState()
    @ObservedObject private var popularState = MovieListState()
    
    var body: some View {
        NavigationView {
            List {
                if nowPlayingState.movies != nil {
                    MoviePosterCarouselView(title: "Now Playing", movies: nowPlayingState.movies!)
                        .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                } else {
                    LoadingView(isLoading: self.nowPlayingState.isLoading, error: self.nowPlayingState.error) {
                        self.nowPlayingState.loadMovies(with: .nowPlaying)
                    }
                }
                
                if upcomingState.movies != nil {
                    MovieBackdropCarouselView(title: "Upcoming", movies: upcomingState.movies!)
                        .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                } else {
                    LoadingView(isLoading: self.upcomingState.isLoading, error: self.upcomingState.error) {
                        self.upcomingState.loadMovies(with: .upcoming)
                    }
                }
                
                if topRatedState.movies != nil {
                    MovieBackdropCarouselView(title: "Top Rated", movies: topRatedState.movies!)
                        .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                } else {
                    LoadingView(isLoading: self.topRatedState.isLoading, error: self.topRatedState.error) {
                        self.topRatedState.loadMovies(with: .topRated)
                    }
                }
                
                if popularState.movies != nil {
                    MovieBackdropCarouselView(title: "Popular", movies: popularState.movies!)
                        .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 16, trailing: 0))
                } else {
                    LoadingView(isLoading: self.popularState.isLoading, error: self.popularState.error) {
                        self.popularState.loadMovies(with: .popular)
                    }
                }
            }
            .navigationBarTitle("The MovieDb")
        }
        .onAppear {
            self.nowPlayingState.loadMovies(with: .nowPlaying)
            self.upcomingState.loadMovies(with: .upcoming)
            self.topRatedState.loadMovies(with: .topRated)
            self.popularState.loadMovies(with: .popular)
        }
     
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}

