//
//  MoviePosterCard.swift
//  SwiftUIMovieDb
//
//  Created by Alfian Losari on 23/05/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct MoviePosterCard: View {
    
    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()
    
    init(movie: Movie) {
        self.movie = movie
        self.imageLoader.loadImage(with: movie.posterURL)
    }
    
    
    var body: some View {
        ZStack {
            if self.imageLoader.image != nil {
                Image(nsImage: self.imageLoader.image!)
                    .resizable()
                    .aspectRatio(204/306, contentMode: .fill)
                    .cornerRadius(8)
                    .shadow(radius: 8)
                .clipped()
                
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .cornerRadius(8)
                    .shadow(radius: 8)
                
                Text(movie.title)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
        }
    }
}

struct MoviePosterCard_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterCard(movie: Movie.stubbedMovie)
    }
}

