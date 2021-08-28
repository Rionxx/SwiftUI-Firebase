//
//  Quote.swift
//  SwiftUI-Firebase
//
//  Created by FX on 2021/08/28.
//

import Foundation

struct Quote: Identifiable {
    var id = UUID()
    
    let quoteText: String
    var liked: Bool = false
}

var testData = [
    Quote(quoteText: "Do or not do. There is no try.", liked: false),
    Quote(quoteText: "Every man dies, not every man really lives", liked: false),
    Quote(quoteText: "Carpe diem, seize the day boys. Make your lives extraordinary", liked: false)
]
