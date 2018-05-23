//
//  ItemCell.swift
//  CdCenturyLink
//
//  Created by serge kone Dossongui on 5/13/18.
//  Copyright © 2018 serge kone Dossongui. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {


    
    @IBOutlet weak var ItemImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var assetTagLabel: UILabel!
    @IBOutlet weak var assetSatusHistoryLabel: UILabel!

    var item: Item! {
        didSet {
           
            idLabel.text = item.id
            assetTagLabel.text = item.assetTag
            assetSatusHistoryLabel.text = item.assetStatusHistory
            
           
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        idLabel.preferredMaxLayoutWidth = idLabel.frame.size.width
        assetSatusHistoryLabel.preferredMaxLayoutWidth = assetSatusHistoryLabel.frame.size.width
        ItemImage.clipsToBounds = true
       
    
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()
        idLabel.preferredMaxLayoutWidth = idLabel.frame.size.width
        assetSatusHistoryLabel.preferredMaxLayoutWidth = assetSatusHistoryLabel.frame.size.width
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
