//
//  QuoteDetail.swift
//  SwiftUI-Firebase
//
//  Created by FX on 2021/08/28.
//

import SwiftUI

struct QuoteDetail: View {
    @Binding var quote: Quote
    
    var body: some View {
        VStack {
            Text(quote.quoteText)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Image(systemName: quote.liked ? "heart.fill" : "heart")
                .foregroundColor(.red)
                .padding(.all)
                .onTapGesture {
                    quote.liked.toggle()
                }
        }
        .font(.largeTitle)
    }
}

struct QuoteDetail_Previews: PreviewProvider {
    static var previews: some View {
        QuoteDetail(quote: .constant(testData[0]))
    }
}
