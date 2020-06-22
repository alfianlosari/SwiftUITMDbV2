//
//  TextFieldView.swift
//  SwiftUIMovieDbMac
//
//  Created by Alfian Losari on 21/06/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct SearchFieldView: NSViewRepresentable {
    
    @Binding var text: String
    let onFocusChange: (Bool) -> Void
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: self.$text, onFocusChange: self.onFocusChange)
    }
    
    func updateNSView(_ nsView: CustomSearchField, context: Context) {
        nsView.stringValue = self.text
    }
    
    func makeNSView(context: Context) -> CustomSearchField {
        let searchField = CustomSearchField(string: self.text)
        searchField.onFocusChange = onFocusChange
        searchField.delegate = context.coordinator
        searchField.placeholderString = "Search"
        searchField.bezelStyle = .roundedBezel
        return searchField
    }
    
    class Coordinator: NSObject, NSSearchFieldDelegate {
        @Binding var text: String
        let onFocusChange: (Bool) -> Void

        init(text: Binding<String>, onFocusChange: @escaping (Bool) -> Void) {
            self._text = text
            self.onFocusChange = onFocusChange
        }

        func controlTextDidEndEditing(_ obj: Notification) {
            self.onFocusChange(false)
        }
                
        func controlTextDidChange(_ obj: Notification) {
            let textfield = obj.object as? NSTextField
            self.text = textfield?.stringValue ?? ""
        }
    }
}

class CustomSearchField: NSSearchField {
    
    var onFocusChange: ((Bool) -> Void)?
    
    override func becomeFirstResponder() -> Bool {
        onFocusChange?(true)
        return super.becomeFirstResponder()
    }   
}
