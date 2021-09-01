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
            for i in snap!.documentChanges {
                //let documentID = i.document.documentID
                let dbID = i.document.get("quoteText") as! String
                let dbQuoteText = i.document.get("quoteText") as! String
                let dbLiked = i.document.get("liked") as! Bool
                
                if let quoteID = UUID(uuidString: dbID) {
                    DispatchQueue.main.async {
                        self.quotes.append(Quote(id: quoteID, quoteText: dbQuoteText, liked: dbLiked))
                    }
                }
            }
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

