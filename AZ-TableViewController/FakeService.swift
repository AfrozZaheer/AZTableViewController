//
//  ViewController.swift
//  AZTableView
//
//  Created by Muhammad Afroz on 7/28/17.
//  Copyright © 2017 AfrozZaheer. All rights reserved.
//


import UIKit

class FakeService {
    
    class func getData (offset: Int = 0, completion: @escaping ((Error?, [String]?) -> Void)) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let fakeData = self.fakeData()
            
            var pageSize = 10
            
            if((offset + pageSize) >= fakeData.count) {
                pageSize = fakeData.count - offset
            }
            
            var results = [String]()
            for i in offset..<(offset + pageSize) {
                results.append(fakeData[i])
            }
            
            completion(nil, results)
        }
    }
    
    private class func fakeData () -> [String] {
        return ["Afroz", "Zaheer", "Stark", "Lanister", "Jon", "Targaryn", "Snow", "NO one ", "Mrs. Rudy Hilll", "Nathen Kutch Jr.", "Elissa Lehner", "Emmanuel Cruickshank", "Annette Bechtelar", "Ashleigh Wolff", "Roberto Crist", "Rocky Stamm", "Adolphus Streich MD", "Andres Rau", "Ms. Opal Olson", "Glenda Balistreri", "Dr. Javon Sipes", "Devante Leuschke", "Liliana Bins", "Mr. Rosie VonRueden", "Nina Batz", "Mrs. Garth Rau", "Jeffrey Bauch", "Judge Schmitt", "Raymundo Rau", "Mr. Kayley Bruen", "Wava Reilly", "Ms. Pablo Mosciski", "Estrella Cremin", "Bertram Gutmann", "Raleigh Schuppe", "Dr. Jace Kuvalis", "Kelly Terry", "Mr. Broderick Crooks", "Tevin Reinger", "Mckenna Graham V", "Howard Kuhn", "Payton Terry", "Ofelia Osinski"]
    }
    
}
