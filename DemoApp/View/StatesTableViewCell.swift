//
//  StatesTableViewCell.swift
//  DemoApp
//
//  Created by Admin on 13/11/20.
//

import UIKit

class StatesTableViewCell: UITableViewCell {
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var sectionName: UILabel!
    @IBOutlet weak var salesLabel: UILabel!

    var item: AppsObject? {
        didSet {
            self.companyNameLabel.text = item?.name
            self.sectionName.text = "Total Sales"
        }
    }
    
    var selectedFilter: SortBy = .total_sales {
        didSet {
            self.sectionName.text = selectedFilter.rawValue
            var value = 0
            switch selectedFilter {
            case .total_sales:
                value = item?.data?.total_sale?.total ?? 0
            case .add_to_cart:
                value = item?.data?.add_to_cart?.total ?? 0
            case .downloads:
                value = item?.data?.downloads?.total ?? 0
            case .user_sessions:
                value = item?.data?.sessions?.total ?? 0
            }
            self.salesLabel.text = "\(item?.currency ?? "$")\(value)"
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
