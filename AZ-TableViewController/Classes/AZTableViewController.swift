//
//  AZTableViewController.swift
//  AZTableView
//
//  Created by Muhammad Afroz on 7/28/17.
//  Copyright © 2017 AfrozZaheer. All rights reserved.
//

import UIKit

class AZTableViewController: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet open var tableView: UITableView?
    @IBOutlet open var nextPageLoaderCell: UITableViewCell?

    
    //MARK: - Properties 
    
    let refresh: UIRefreshControl = UIRefreshControl()
    @IBOutlet open var noResults: UIView?
    @IBOutlet open var loadingView: UIView?
    @IBOutlet open var errorView: UIView?

    
    var numberOfRows = 0
    open var haveMoreData = false
    open var isFetchingData = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresh.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        tableView?.addSubview(refresh)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension AZTableViewController {
    
    
    @objc(numberOfSectionsInTableView:)
    open func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @objc(tableView:numberOfRowsInSection:)
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if showNextPageLoaderCell(tableView: tableView, section: section) {
            
            return AZtableView(tableView, numberOfRowsInSection: section) + 1
        }
        
        return AZtableView(tableView, numberOfRowsInSection: section)
    }
    
    open func AZtableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    @objc(tableView:heightForRowAtIndexPath:)
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if showNextPageLoaderCell(tableView: tableView, section: indexPath.section, row: indexPath.row), let nextPageLoaderCell = nextPageLoaderCell {
            return nextPageLoaderCell.frame.height
        }
        
        return AZtableView(tableView, heightForRowAt: indexPath)
    }
    
    open func AZtableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    @objc(tableView:cellForRowAtIndexPath:)
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if showNextPageLoaderCell(tableView: tableView, section: indexPath.section, row: indexPath.row), let nextPageLoaderCell = nextPageLoaderCell {
            if !self.isFetchingData {
                fetchNextData()
            }
            return nextPageLoaderCell
        }
        
        if shouldfetchNextData(tableView: tableView, indexPath: indexPath) {
            fetchNextData()
        }
        
        return AZtableView(tableView, cellForRowAt: indexPath)
    }
    
    open func AZtableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}


//MARK: - For Api's
extension AZTableViewController {
    
    open func fetchData()  {
        numberOfRows = 0
        refresh.endRefreshing()
        hideNoResultsView()
        hideErrorView()
        hideNoResultsLoadingView()
        showNoResultsLoadingView()
        
        isFetchingData = true
        
    }
    
    open func didfetchData(resultCount: Int, haveMoreData: Bool) {
        hideNoResultsLoadingView()
        isFetchingData = false
        self.haveMoreData = haveMoreData
        if resultCount > 0 {
            numberOfRows += resultCount
            hideNoResultsView()
            tableView?.reloadData()
        }
        else {
            showNoResultsView()
        }
    }
    
    open func fetchNextData () {
        isFetchingData = true
        hideErrorView()
    }
    
    open func errorDidOccured(error: Error?) {
        isFetchingData = false
        hideNoResultsView()
        hideErrorView()
        hideNoResultsLoadingView()
        if numberOfRows > 0 {
            let alert = UIAlertController(title: "Error!", message: error?.localizedDescription, preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .default, handler: { (action) in
                
            })
            alert.addAction(okayAction)
            self.present(alert, animated: true, completion: nil)
        }
        else {
            showErrorView(error: error)
        }
    }
    
    
    open func showNextPageLoaderCell (tableView: UITableView? = nil, section: Int? = nil, row: Int? = nil) -> Bool {
       
        if nextPageLoaderCell != nil, haveMoreData {
        
            if let tableView = tableView, let section = section {
                // check if last section
                if self.numberOfSections(in: tableView) != section + 1 {
                    return false
                }
                
                if let row = row {
                    // check if last row
                    if self.tableView(tableView, numberOfRowsInSection: section) != row + 1 {
                        return false
                    }
                }
            }
            
            return true
        }
        
        return false
    }
    
    open func shouldfetchNextData(tableView: UITableView, indexPath: IndexPath) -> Bool {
        if self.isFetchingData || !self.haveMoreData || self.nextPageLoaderCell == nil {
            return false
        }
        
        // if not last section
        if self.numberOfSections(in: tableView) != indexPath.section + 1 {
            return false
        }
        
        if indexPath.row >= self.tableView(tableView, numberOfRowsInSection: indexPath.section) - 3 {
            return true
        }
        
        return false
    }
    
    
}

//MARK: - Show Hide error loading Views
extension AZTableViewController {
    
    func showNoResultsView() {
        if noResults != nil{
            noResults?.isHidden = false
            noResults?.frame = getFrame()
            tableView?.addSubview(noResults!)
        }
    }
    func hideNoResultsView() {
        if noResults != nil{
            tableView?.willRemoveSubview(noResults!)
            noResults?.removeFromSuperview()
        }
    }
    func showNoResultsLoadingView() {
        if loadingView != nil{

            loadingView?.isHidden = false
            loadingView?.frame = getFrame()
            tableView?.addSubview(loadingView!)
            refresh.endRefreshing()
            tableView?.isUserInteractionEnabled = false
        }
    }
    func hideNoResultsLoadingView() {
        if loadingView != nil{
            
            tableView?.willRemoveSubview(loadingView!)
            loadingView?.removeFromSuperview()
            tableView?.isUserInteractionEnabled = true
    
        }
    }
    func showErrorView(error: Error?) {
        if errorView != nil{

            errorView?.isHidden = false
            errorView?.frame = getFrame()
            tableView?.addSubview(errorView!)
        }
    }
    func hideErrorView() {
        if errorView != nil{
            tableView?.willRemoveSubview(errorView!)
            errorView?.removeFromSuperview()
        }
    }
    func getFrame() -> CGRect{
        return CGRect(x: 0, y: 0, width: (tableView?.frame.size.width)!, height: (tableView?.frame.size.height)!)
    }
}
