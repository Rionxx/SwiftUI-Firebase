//
//  QuoteDetail.swift
//  SwiftUI-Firebase
//
//  Created by FX on 2021/08/28.
//

import SwiftUI

struct QuoteDetail: View {
    var quote: Quote
    @ObservedObject var quotesFactory = testFactory
    
    var body: some View {
        let quoteIdx = quotesFactory.index(of: quote)
        VStack {
            Text(quotesFactory.quotes[quoteIdx].quoteText)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Image(systemName: quotesFactory.quotes[quoteIdx].liked ? "heart.fill" : "heart")
                .foregroundColor(.red)
                .padding(.all)
                .onTapGesture {
                    quotesFactory.quotes[quoteIdx].liked.toggle()
                }
        }
        .font(.largeTitle)
    }
}

struct QuoteDetail_Previews: PreviewProvider {
    static var previews: some View {
        QuoteDetail(quote: testFactory.quotes[0])
    }
}
