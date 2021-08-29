//
//  ContentView.swift
//  SwiftUI-Firebase
//
//  Created by FX on 2021/08/28.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var quotesFactory: QuotesFactory
    
    var body: some View {
        NavigationView {
            List {
                ForEach(quotesFactory.quotes) { quote in
                    QuoteCell(quote: quote)
                }
                .onDelete(perform: { indexSet in
                    quotesFactory.quotes.remove(atOffsets: indexSet)
                })
                .onMove(perform: { indices, newOffset in
                    quotesFactory.quotes.move(fromOffsets: indices, toOffset: newOffset)
                })
                
                Spacer()
                Text("\(quotesFactory.quotes.count) Quotes")
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .navigationTitle("Quotes")
            .toolbar {
                EditButton()
            }
        }
    }
}

struct QuoteCell: View {
     var quote: Quote
    
    var body: some View {
        NavigationLink(destination: QuoteDetail(quote: quote)) {
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
