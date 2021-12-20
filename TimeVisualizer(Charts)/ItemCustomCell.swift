//
//  ItemCustomCell.swift
//  TimeVisualizer(Charts)
//
//  Created by admin on 15/05/1443 AH.
//

import UIKit
protocol TableViewDelegate: AnyObject{

    func itemSaved(with task: String)
}

class ItemCustomCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var itemTextField: UITextField!
    
    weak var delegate: TableViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
    }

    @IBAction func action(_ sender: UITextField) {
        if let task = itemTextField.text{
            
        delegate?.itemSaved(with: task)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
