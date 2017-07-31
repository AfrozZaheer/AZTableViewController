//
//  ViewController.swift
//  AZTableView
//
//  Created by Muhammad Afroz on 7/28/17.
//  Copyright © 2017 AfrozZaheer. All rights reserved.
//

import UIKit

class ViewController: AZTableViewController {

    var lastIndex = 0
    var results = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    override func AZtableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        {
            cell.textLabel?.text = results[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    override func AZtableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
}

extension ViewController {
    
    override func fetchData() {
        super.fetchData()
        
        FakeService.getData { (error, results) in
           
            if let resu = results {
                self.results.removeAll()
                self.results.append(contentsOf: resu)
                self.didfetchData(resultCount: resu.count, haveMoreData: true)
            }
                
            else if let error = error {
                self.errorDidOccured(error: error)
            }
        }
    }
    
    override func fetchNextData() {
        super.fetchNextData()
        
        FakeService.getData (offset: results.count) { (error, results) in
            
            if let resu = results {
                
                self.results.append(contentsOf: resu)
                if self.results.count < 50 { // you probably get next page exist from service.
                    self.didfetchData(resultCount: resu.count, haveMoreData: true)
                }
                else {
                    self.didfetchData(resultCount: resu.count, haveMoreData: false)
                }
            }
            else if let error = error {
                self.errorDidOccured(error: error)
            }
        }
        
    }
    
}
