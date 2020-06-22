//
//  MovieRowView.swift
//  SwiftUIMovieDbMac
//
//  Created by Alfian Losari on 20/06/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct MovieRowView: View {
    
    let movie: Movie
    
    
    var body: some View {
        ZStack {
            HStack(alignment: .center, spacing: 0) {
                   MovieRowImage(imageURL: movie.backdropURL)
                       .frame(width: 88)
                    .padding(.trailing, 8)
                   
                   VStack(alignment: .leading, spacing: 4) {
                       Text(movie.title)
                           .font(.system(size: 12, weight: .heavy))
                       Text(movie.overview)
                           .font(.system(size: 12, weight: .medium))
                           .lineLimit(3)
                       
                       
                   }
                Spacer()
               }
               .padding(.vertical, 8)
               .frame(height: 80)
               
            
            Rectangle().fill(Color(NSColor.separatorColor)).frame(height: 1)
                .offset(y: 43)
            
            
        }
   
    }
}

struct MovieRowImage: View {
    
    @ObservedObject var imageLoader = ImageLoader()
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
        .cornerRadius(4)
        .onAppear {
            self.imageLoader.loadImage(with: self.imageURL)
        }
    }
}


struct MovieRowView_Previews: PreviewProvider {
    static var previews: some View {
        MovieRowView(movie: Movie.stubbedMovies[0])
            .frame(width: 300)
    }
}
