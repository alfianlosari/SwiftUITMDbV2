//
//  ActivityIndicatorView.swift
//  SwiftUIMovieDbMac
//
//  Created by Alfian Losari on 20/06/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import Foundation
import SwiftUI

struct ActivityIndicatorView: NSViewRepresentable {
    
    func makeNSView(context: Context) -> NSProgressIndicator {
        let indicator = NSProgressIndicator()
        indicator.style = .spinning
        indicator.startAnimation(nil)
        return indicator
    }
    
    func updateNSView(_ nsView: NSProgressIndicator, context: Context) {
        
    }
}
