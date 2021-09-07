//
//  QuotesFactory.swift
//  SwiftUI-Firebase
//
//  Created by FX on 2021/08/29.
//

import Foundation
import FirebaseFirestore

class QuotesFactory: ObservableObject {
    @Published var quotes: [Quote]
    
    init(quotes: [Quote] = []) {
        self.quotes = quotes
        let db = Firestore.firestore()
        db.collection("Quotes").addSnapshotListener { (snap, err) in
            if err != nil {
                print("Error")
                return
            }
            
            self.quotes.removeAll()
            
            let documents = snap!.documents
            let dbID = documents.map { $0["id"] as! String }
            let dbQuoteText = documents.map { $0["quoteText"] as! String }
            let dbLiked = documents.map { $0["liked"] as! Bool }
            
            for i in 0..<dbID.count {
                if let quoteID = UUID(uuidString: dbID[i]) {
                    self.quotes.append(Quote(id: quoteID, quoteText: dbQuoteText[i], liked: dbLiked[i]))
                }
            }
            
            let quoteData = try! JSONEncoder().encode(self.quotes)
            UserDefaults(suiteName: "group.com.Quotes.quoteContainer")!.set(quoteData, forKey: "quoteData") 
        }
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

