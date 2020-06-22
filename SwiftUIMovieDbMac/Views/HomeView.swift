//
//  MovieListView.swift
//  SwiftUIMovieDB
//
//  Created by Alfian Losari on 22/05/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject private var nowPlayingState = MovieListState()
    @ObservedObject private var upcomingState = MovieListState()
    @ObservedObject private var topRatedState = MovieListState()
    @ObservedObject private var popularState = MovieListState()
    
    @State var selectedMovie: Movie?
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing: 24) {
                if nowPlayingState.movies != nil {
                    MoviePosterCarouselView(title: "Now Playing", movies: nowPlayingState.movies!, selectedMovie: self.$selectedMovie)
                        .padding(.top)
                    
                } else {
                    LoadingView(isLoading: self.nowPlayingState.isLoading, error: self.nowPlayingState.error) {
                        self.nowPlayingState.loadMovies(with: .nowPlaying)
                    }
                }
                
                if upcomingState.movies != nil {
                    MovieBackdropCarouselView(title: "Upcoming", movies: upcomingState.movies!, selectedMovie: self.$selectedMovie)
                } else {
                    LoadingView(isLoading: self.upcomingState.isLoading, error: self.upcomingState.error) {
                        self.upcomingState.loadMovies(with: .upcoming)
                    }
                }
                
                
                if topRatedState.movies != nil {
                    MovieBackdropCarouselView(title: "Top Rated", movies: topRatedState.movies!, selectedMovie: self.$selectedMovie)
                    
                } else {
                    LoadingView(isLoading: self.topRatedState.isLoading, error: self.topRatedState.error) {
                        self.topRatedState.loadMovies(with: .topRated)
                    }
                }
                
                
                if popularState.movies != nil {
                    MovieBackdropCarouselView(title: "Popular", movies: popularState.movies!, selectedMovie: self.$selectedMovie)
                        .padding(.bottom)
                    
                } else {
                    LoadingView(isLoading: self.popularState.isLoading, error: self.popularState.error) {
                        self.popularState.loadMovies(with: .popular)
                    }
                }
            }
            
        }

            
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .sheet(item: self.$selectedMovie) { movie in
            NavigationView {
                VStack(spacing: 0) {
                    Button(action: {
                        self.selectedMovie = nil
                    }) {
                        Text("Close")
                    }
                    .foregroundColor(Color(NSColor.systemBlue))
                    .buttonStyle(PlainButtonStyle())
                    .padding(.vertical)
                    
                    Divider()
                    MovieDetailView(movie: movie)
                }
            }
            .navigationViewStyle(DefaultNavigationViewStyle())
            .frame(width: 600, height: 700)
        }
        .onAppear {
            self.nowPlayingState.loadMovies(with: .nowPlaying)
            self.upcomingState.loadMovies(with: .upcoming)
            self.topRatedState.loadMovies(with: .topRated)
            self.popularState.loadMovies(with: .popular)
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


