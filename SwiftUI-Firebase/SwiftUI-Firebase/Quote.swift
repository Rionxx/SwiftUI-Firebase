//
//  Quote.swift
//  SwiftUI-Firebase
//
//  Created by FX on 2021/08/28.
//

import Foundation

struct Quote: Identifiable, Codable {
    var id = UUID()
    
    let quoteText: String
    var liked: Bool = false
}

var testData = [
    Quote(quoteText: "Do or not do. There is no try.", liked: false),
    Quote(quoteText: "Your focus determines your reality", liked: false),
    Quote(quoteText: "In my experience, there is no sucho thing as luck", liked: false),
    Quote(quoteText: "Yout eyes can deceive you. Don't trust them", liked: false),
    Quote(quoteText: "Every man dies. not really lives.", liked: false),
    Quote(quoteText: "Carpe diem, seize the day boys. Make your lives extraordinary.", liked: false),
    Quote(quoteText: "The world is your oyster. It's up to you to find the pearls.", liked: false),
    Quote(quoteText: "I am not what happend to me. I am what I choose to become.", liked: false)
]
