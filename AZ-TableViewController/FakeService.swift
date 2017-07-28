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
        return ["Dock Gaylord", "Mr. Izabella Ziemann", "Haskell Medhurst DDS", "Rebeka Torp", "Shannon Kub", "Kara Donnelly", "Johnathan Kuphal", "Jermaine Shanahan", "Mrs. Rudy Hilll", "Nathen Kutch Jr.", "Elissa Lehner", "Emmanuel Cruickshank", "Annette Bechtelar", "Ashleigh Wolff", "Roberto Crist", "Rocky Stamm", "Adolphus Streich MD", "Andres Rau", "Ms. Opal Olson", "Glenda Balistreri", "Dr. Javon Sipes", "Devante Leuschke", "Liliana Bins", "Mr. Rosie VonRueden", "Nina Batz", "Mrs. Garth Rau", "Jeffrey Bauch", "Judge Schmitt", "Raymundo Rau", "Mr. Kayley Bruen", "Wava Reilly", "Ms. Pablo Mosciski", "Estrella Cremin", "Bertram Gutmann", "Raleigh Schuppe", "Dr. Jace Kuvalis", "Kelly Terry", "Mr. Broderick Crooks", "Tevin Reinger", "Mckenna Graham V", "Howard Kuhn", "Payton Terry", "Ofelia Osinski", "Lera Bogan", "Luz Gutmann DVM", "Bulah Schaefer", "Elissa Williamson", "Joanne Schamberger", "Orpha Eichmann", "Haylee Hartmann", "Cary Toy", "Danial Marvin", "Mrs. Wilbert Reynolds", "Dr. Mable Ledner", "Albin Leffler", "Osbaldo Marks", "Omari Wolf MD", "Isabelle Schroeder", "Douglas Kohler", "Tomasa Reichert", "Larue Von", "Taylor Roberts MD", "Mose Frami", "Patrick Kautzer I", "Godfrey Gottlieb V", "Pearlie Kuhlman MD", "Dixie Kiehn I", "Karianne Larson", "Terry Daugherty Sr.", "Newell Pfannerstill I", "Lola Johns", "Freeda Wintheiser PhD", "Yolanda Abbott", "Lauryn Howe", "June Kautzer", "Zoie Bradtke", "Ms. Vanessa Watsica", "Janae Davis", "Norene Harris", "Brooks Ebert Sr."]
    }
    
}
