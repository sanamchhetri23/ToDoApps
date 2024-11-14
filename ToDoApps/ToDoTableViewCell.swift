//
//  ToDoTableViewCell.swift
//  ToDoApps
//
//  Created by Peek A Boo on 2024-11-10.
//

import UIKit

protocol ToDoTableViewCellDelegate: AnyObject{
    func didTapDeleteButton(_ cell: ToDoTableViewCell)
}

class ToDoTableViewCell: UITableViewCell {
    @IBOutlet var ResultTitle: UILabel!
    @IBOutlet var ResultDescription: UILabel!
    @IBOutlet var DeleteButton: UIButton!
    weak var delegate: ToDoTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    @IBAction func DeleteButtonTapped(_ sender: UIButton) {
        delegate?.didTapDeleteButton(self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
