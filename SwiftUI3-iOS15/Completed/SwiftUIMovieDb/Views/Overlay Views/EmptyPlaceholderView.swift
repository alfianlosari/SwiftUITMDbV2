//
//  EmptyPlaceholderView.swift
//  SwiftUIMovieDb
//
//  Created by Alfian Losari on 10/31/21.
//  Copyright © 2021 Alfian Losari. All rights reserved.
//

import SwiftUI

struct EmptyPlaceholderView: View {
    
    let text: String
    let image: Image?
    
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            if let image = image {
                image
                    .imageScale(.large)
                    .font(.system(size: 52))
            }
            Text(text)
            Spacer()
        }
    }
}

struct EmptyPlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyPlaceholderView(text: "No Movies", image: Image(systemName: "film"))
    }
}
