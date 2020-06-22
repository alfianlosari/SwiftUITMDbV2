//
//  MovieBackdropCarouselView.swift
//  SwiftUIMovieDb
//
//  Created by Alfian Losari on 23/05/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct MovieBackdropCarouselView: View {
    
    let title: String
    let movies: [Movie]
    @Binding var selectedMovie: Movie?
            
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal, 32)
            
            ScrollView(.horizontal, showsIndicators: true) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(self.movies) { movie in
                        MovieBackdropCard(movie: movie)
                            .frame(width: 272, height: 200)
                            
                            
                            .onTapGesture {
                                self.selectedMovie = movie
                        }
                    }
                }
                .padding(.horizontal, 32)
            }
        }
    }
}

struct MovieBackdropCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        MovieBackdropCarouselView(title: "Latest", movies: Movie.stubbedMovies, selectedMovie: .constant(nil))
    }
}

struct ListCellHelper: NSViewRepresentable {

    let proxy: ListCellProxy 

    func makeNSView(context: Context) -> NSView {
        return NSView()
    }

    func updateNSView(_ nsView: NSView, context: Context) {
        proxy.catchCell(for: nsView)
    }
}

class ListCellProxy {

    private var tableRowView: NSTableRowView?

    func catchCell(for view: NSView) {
        tableRowView = view.enclosingTableRowView()
        tableRowView?.selectionHighlightStyle = .none
        
    }
}
extension NSView {
    func enclosingTableRowView() -> NSTableRowView? {
        var next: NSView? = self
        repeat {
            next = next?.superview
            if let rowView = next as? NSTableRowView {
                return rowView
            }
        } while next != nil
        return nil
    }
}

