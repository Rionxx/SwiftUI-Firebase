//
//  ContentView.swift
//  SwiftUI-Firebase
//
//  Created by FX on 2021/08/28.
//

import SwiftUI
import FirebaseFirestore

struct ContentView: View {
    @ObservedObject var quotesFactory: QuotesFactory
    @State var showAdd = false
    @State var quoteTextField: String = ""
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(quotesFactory.quotes) { quote in
                        QuoteCell(quote: quote)
                    }
                    .onDelete(perform: { indexSet in
                        //quotesFactory.quotes.remove(atOffsets: indexSet)
                        let quoteUUID = indexSet.map {
                            quotesFactory.quotes[$0].id
                        }
                        self.deleteQuote(with: quoteUUID[0].uuidString)
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
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button("Add", action: newQuote)
                    }
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
            }
            
            if showAdd {
                HStack {
                    TextField("Placeholder", text: $quoteTextField)
                    Button("Save Quote", action: saveQuote)
                }
                .padding(.all)
                .frame(height: 100)
            }
        }
    }
    
    func deleteQuote(with id: String) {
        let db = Firestore.firestore()
        db.collection("Quotes").whereField("id", isEqualTo: id).getDocuments{(snap, err) in
            if err != nil {
                print("Error")
                return
            }
            
            for i in snap!.documents {
                DispatchQueue.main.async {
                    i.reference.delete()
                }
            }
        }
    }
    
    func newQuote() {
        showAdd = true
    }
    
    func saveQuote() {
        let db = Firestore.firestore()
        let id = UUID().uuidString
        db.collection("Quotes").document().setData(["id": id, "quoteText": quoteTextField, "liked": false])
        showAdd = false
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
