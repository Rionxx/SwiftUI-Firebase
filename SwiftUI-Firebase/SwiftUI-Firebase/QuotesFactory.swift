//
//  QuotesFactory.swift
//  SwiftUI-Firebase
//
//  Created by FX on 2021/08/29.
//

import Foundation

class QuotesFactory: ObservableObject {
    @Published var quotes: [Quote]
    
    init(quotes: [Quote] = []) {
        self.quotes = quotes
    }
    
    func index(of quote: Quote) -> Int {
        for index in 0..<self.quotes.count {
            if self.quotes[index].id == quote.id {
                return index
            }
        }
        return 0
    }
}

let testFactory = QuotesFactory(quotes: testData) 
