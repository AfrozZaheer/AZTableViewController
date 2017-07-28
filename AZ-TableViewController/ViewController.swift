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
        // Dispose of any resources that can be recreated.
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
}

extension ViewController {
    
    override func fetchData() {
        super.fetchData()
        
        results.removeAll()
        
        FakeService.getData { (error, results) in
            if let error = error {
                self.errorDidOccured(error: error)
            }
            else if let resu = results {
                self.didfetchData(resultCount: resu.count, haveMoreData: true)
                self.results.append(contentsOf: resu)
            }
        }
    }
    
    override func fetchNextData() {
        super.fetchNextData()
        
        FakeService.getData (offset: results.count) { (error, results) in
            if let error = error {
                self.errorDidOccured(error: error)
            }
            else if let resu = results {
                if self.results.count < 25 {
                    self.didfetchData(resultCount: resu.count, haveMoreData: true)
                }
                else {
                    self.didfetchData(resultCount: resu.count, haveMoreData: false)
                }
                self.results.append(contentsOf: resu)
            }
        }
        
    }
    
}
