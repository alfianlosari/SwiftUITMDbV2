//
//  MovieDetailView.swift
//  SwiftUIMovieDb
//
//  Created by Alfian Losari on 24/05/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct MovieDetailView: View {
    
    let movie: Movie
    @ObservedObject private var movieDetailState = MovieDetailState()
    
    init(movie: Movie) {
        self.movie = movie
        self.movieDetailState.loadMovie(id: self.movie.id)
    }
    
    var body: some View {
        ZStack {
            
            if movieDetailState.movie != nil {
                MovieDetailListView(movie: self.movieDetailState.movie!)
            }
            
            LoadingView(isLoading: self.movieDetailState.isLoading, error: self.movieDetailState.error) {
                self.movieDetailState.loadMovie(id: self.movie.id)
            }
            
        }
        .frame(width: 600)
    }
    
}

struct MovieDetailListView: View {
    
    let movie: Movie
    
    private let imageLoader = ImageLoader()
    
    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading, spacing: 16) {
                MovieDetailImage(imageLoader: imageLoader, imageURL: self.movie.backdropURL)
                Text(movie.title)
                    .font(.largeTitle)
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(movie.genreText)
                        Text("·")
                        Text(movie.yearText)
                        Text(movie.durationText)
                    }
                    
                    HStack {
                        if !movie.ratingText.isEmpty {
                            Text(movie.ratingText).foregroundColor(.yellow)
                        }
                        Text(movie.scoreText)
                    }
                }
                .font(.system(size: 12, weight: .bold))
                Divider()
                
                VStack(alignment: .leading, spacing: 16) {
                    Text(movie.overview)
                        .lineLimit(10)
                }
                Divider()
                HStack(alignment: .top, spacing: 4) {
                    if movie.cast != nil && movie.cast!.count > 0 {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Starring").font(.headline)
                                .padding(.bottom, 4)
                            ForEach(self.movie.cast!.prefix(9)) { cast in
                                Text(cast.name)
                            }
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        Spacer()
                    }
                    
                    if movie.crew != nil && movie.crew!.count > 0 {
                        VStack(alignment: .leading, spacing: 4) {
                            if movie.directors != nil && movie.directors!.count > 0 {
                                Text("Director(s)").font(.headline)
                                    .padding(.bottom, 4)
                                ForEach(self.movie.directors!.prefix(2)) { crew in
                                    Text(crew.name)
                                }
                            }
                            
                            if movie.producers != nil && movie.producers!.count > 0 {
                                Text("Producer(s)").font(.headline)
                                    .padding(.top)
                                    .padding(.bottom, 4)
                                ForEach(self.movie.producers!.prefix(2)) { crew in
                                    Text(crew.name)
                                }
                            }
                            
                            if movie.screenWriters != nil && movie.screenWriters!.count > 0 {
                                Text("Screenwriter(s)").font(.headline)
                                    .padding(.top)
                                    .padding(.bottom, 4)
                                ForEach(self.movie.screenWriters!.prefix(2)) { crew in
                                    Text(crew.name)
                                }
                            }
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    }
                }
                
                Divider()
                
                if movie.youtubeTrailers != nil && movie.youtubeTrailers!.count > 0 {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Trailers").font(.headline)
                            .padding(.bottom, 4)
                        ForEach(movie.youtubeTrailers!) { trailer in
                            Button(action: {
                                NSWorkspace.shared.open(trailer.youtubeURL!)
                            }) {
                                HStack {
                                    Text(trailer.name)
                                }
                            }
                            .foregroundColor(Color(NSColor.systemBlue))
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct MovieDetailImage: View {
    
    @ObservedObject var imageLoader: ImageLoader
    let imageURL: URL
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color.gray.opacity(0.3))
            if self.imageLoader.image != nil {
                Image(nsImage: self.imageLoader.image!)
                    .resizable()
            }
        }
        .aspectRatio(16/9, contentMode: .fit)
        .cornerRadius(8)
            
        .onAppear {
            self.imageLoader.loadImage(with: self.imageURL)
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MovieDetailView(movie: Movie.stubbedMovie)
        }
    }
}
