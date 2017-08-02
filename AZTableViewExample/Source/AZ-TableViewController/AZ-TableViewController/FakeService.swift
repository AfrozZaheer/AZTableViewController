//
//  FakeService.swift
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
        return ["Afroz", "Zaheer", "Stark", "Lanister", "Jon", "Targaryn", "Snow", "No One "," Tyrion Lannister"," Cersei Lannister"," Daenerys Targaryen "," Jon Snow"," Sansa Stark"," Arya Stark"," Jaime Lannister"," Jorah Mormont"," Theon Greyjoy"," Samwell Tarly"," Lord Varys"," Petyr 'Littlefinger' Baelish"," Brienne of Tarth "," Davos Seaworth","Bran Stark"," Missandei "," Bronn"," Grand Maester Pycelle","Sandor 'The Hound' Clegane"," Melisandre"," Tywin Lannister"," Margaery Tyrell <3","Afroz", "Zaheer", "Stark", "Lanister", "Jon", "Targaryn", "Snow", "No One "," Tyrion Lannister"," Cersei Lannister"," Daenerys Targaryen "," Jon Snow"," Sansa Stark"," Arya Stark"," Jaime Lannister"," Jorah Mormont"," Theon Greyjoy"," Samwell Tarly"," Lord Varys"," Petyr 'Littlefinger' Baelish"," Brienne of Tarth "," Davos Seaworth","Bran Stark"," Missandei "," Bronn"," Grand Maester Pycelle","Sandor 'The Hound' Clegane"," Melisandre"," Tywin Lannister"," Margaery Tyrell <3"]
    }
    
}
