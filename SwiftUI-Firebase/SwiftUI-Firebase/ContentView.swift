//
//  ContentView.swift
//  SwiftUI-Firebase
//
//  Created by FX on 2021/08/28.
//

import SwiftUI

struct ContentView: View {
    @State var quotes: [Quote] = testData
    
    var body: some View {
        NavigationView {
            List {
                ForEach(quotes.indices) { idx in
                    QuoteCell(quote: $quotes[idx])
                }
                Spacer()
                Text("\(quotes.count)")
                Spacer()
            }
            .navigationTitle("Quotes")
        }
    }
}

struct QuoteCell: View {
    @Binding var quote: Quote
    
    var body: some View {
        NavigationLink(destination: QuoteDetail(quote: $quote)) {
            HStack {
                Image(systemName: quote.liked ? "heart.fill" : "heart")
                    .foregroundColor(.red)
                    .padding(.all)
                    .font(.title)
                Text(quote.quoteText)
                    .font(.title)
                    .padding(.vertical)
            }
        }
    }
}
