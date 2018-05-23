//
//  StoreViewController.swift
//  CdCenturyLink
//
//  Created by serge kone Dossongui on 5/13/18.
//  Copyright © 2018 serge kone Dossongui. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.performSegue(withIdentifier: "toStockV", sender: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTapOnToSockButton(_ sender: Any) {
        
            self.performSegue(withIdentifier: "toStockV", sender: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStockV" {
            navigationItem.title = "Assets in store"
            let destinationVC = segue.destination as! StockViewController
            
        }
    }

}
