//
//  StockViewController.swift
//  CdCenturyLink
//
//  Created by serge kone Dossongui on 5/13/18.
//  Copyright © 2018 serge kone Dossongui. All rights reserved.
//

import UIKit
import AlamofireImage
import Foundation

class StockViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var items: [Item] = []
    var itemImageArray: [String] = ["A","B","C","D","E","F"]
    
    //refreshcontrol
    
    var refreshcontrol : UIRefreshControl!
    
    
    
    //header variable
    
    let  HeaderViewIdentifier = "TableViewHeaderView"
    var headerView = UIView()
    var LoadImageView = UIImageView()
    var UnloadImageView = UIImageView()
    var LoadImageLabel = UILabel()
    var UnloadImageLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //tableview Set up
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        
        //create instance of UI refreshcontrol
        
        refreshcontrol = UIRefreshControl()
        refreshcontrol.addTarget(self, action: #selector(StockViewController.didPullToRefresh(_:)    ), for: .valueChanged)
        tableView.insertSubview(refreshcontrol, at: 0)
        
        
        
        //tableView.rowHeight = UITableViewAutomaticDimension
        //tableView.estimatedRowHeight = 120
        
        
    }
    
    
    func fetchLocalData() {
        
        self.refreshcontrol.beginRefreshing()
        APIManager.shared.getLocalHomeStocks { (items, error) in
            if let items = items {
                DispatchQueue.main.async {
                    self.items = items
                    self.tableView.reloadData()
                }
                self.refreshcontrol.endRefreshing()
            } else if let error = error {
                
                self.DisplayAlert(error: error)
                print("Error getting home Stock items: " + error.localizedDescription)
            }
        }
        
    }
    
    
    func fetchData() {
        
    
        
        self.refreshcontrol.beginRefreshing()
        APIManager.shared.getHomeStocks { (items, error) in
            if let items = items {
                DispatchQueue.main.async {
                    self.items = items
                    self.tableView.reloadData()
                }
                self.refreshcontrol.endRefreshing()
            } else if let error = error {
                
                self.DisplayAlert(error: error)
                print("Error getting home Stock items: " + error.localizedDescription)
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        fetchData()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func DisplayAlert(error:Error?) {
        
        
        let alertController = UIAlertController(title: "Loading Failed ", message: error?.localizedDescription as? String, preferredStyle: .alert)
        
        // create a cancel action
        
        let cancelAction = UIAlertAction(title: "Try again", style: .cancel) { (action) in
            self.fetchData()
        }
        
        // create a ok action
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.fetchLocalData()
        }
        
        // add the cancel action to the alertController
        
        alertController.addAction(cancelAction)
        alertController.addAction(OKAction)
        
        present(alertController, animated: true)
    }
    
    
    
    
    @objc func didPullToRefresh(_ refreshcontorl: UIRefreshControl){
        
        fetchData()
        
    }
    

}


//tableView Data

extension StockViewController:  UITableViewDataSource{
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        cell.item = items[indexPath.row]

        let index = indexPath.row as Int?
        if index! >= itemImageArray.count {
        cell.ItemImage.image = UIImage(named: "emptyimage")
        }else{
            cell.ItemImage.image = UIImage(named: (itemImageArray[index!] as? String)! )
        }
        
        
        
        
    
   
        
        return cell
    
    }
    
    
}

//tableview UI

extension StockViewController:  UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        //header definition
        
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: self.tableView.frame.height))
        headerView.backgroundColor = UIColor.white
        headerView.viewDesign = true
    
        
        LoadImageView = UIImageView(frame: CGRect(x: headerView.frame.origin.x + 80, y: headerView.frame.origin.y + 40, width: 100, height: 100))
        LoadImageView.image = UIImage(named: "IconLoadImage")
        
        UnloadImageView = UIImageView(frame: CGRect(x: headerView.frame.width - 160 , y: headerView.frame.origin.y + 40, width: 100, height: 100))
        UnloadImageView.image = UIImage(named: "IconLoadImage")
     
        //some design
        
      
        
        
        //label
        
        LoadImageLabel = UILabel(frame: CGRect(x: headerView.frame.origin.x + 110, y: headerView.frame.origin.y + 140, width: 40, height: 40))
        LoadImageLabel.text = "Load"
        
        LoadImageLabel.font = UIFont(name: "Avenir Next", size: 17.0)
        LoadImageLabel.textColor = UIColor.darkGray
      
        UnloadImageLabel = UILabel(frame: CGRect(x: headerView.frame.width - 140 , y: headerView.frame.origin.y + 140, width: 80, height: 40))
        UnloadImageLabel.text = "UnLoad"
        
        UnloadImageLabel.font = UIFont(name: "Avenir Next", size: 17.0)
        UnloadImageLabel.textColor = UIColor.darkGray
     
        
        

        //had UI component to header view
        
        headerView.addSubview(LoadImageView)
        headerView.addSubview(UnloadImageView)
        headerView.addSubview(LoadImageLabel)
        headerView.addSubview(UnloadImageLabel)
        
        return headerView
        
    }
   
}

