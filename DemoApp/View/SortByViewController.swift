//
//  SortByViewController.swift
//  DemoApp
//
//  Created by Admin on 13/11/20.
//

import UIKit

protocol sortByFilterDelegate: class {
    func selectedFilter(selectedFilter: SortBy)
}

class SortByViewController: BottomPopupViewController {
    var height: CGFloat?
    var topCornerRadius: CGFloat?
    var presentDuration: Double?
    var dismissDuration: Double?
    var shouldDismissInteractivelty: Bool?
    var delegate: sortByFilterDelegate?
    var selectedState: SortBy? = .total_sales
    @IBOutlet weak var tick1: UIImageView!
    @IBOutlet weak var tick2: UIImageView!
    @IBOutlet weak var tick3: UIImageView!
    @IBOutlet weak var tick4: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        switch selectedState {
        case .total_sales:
            self.UpdateUI(tag: 1)
        case .add_to_cart:
            self.UpdateUI(tag: 2)
        case .downloads:
            self.UpdateUI(tag: 3)
        case .user_sessions:
            self.UpdateUI(tag: 4)
        default:
            self.UpdateUI(tag: 1)

        }
    }
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sortBYAction(_ sender: Any) {
        self.UpdateUI(tag: (sender as AnyObject).tag)
        dismiss(animated: true, completion: nil)
    }
    
    func UpdateUI(tag: Int) {
        tick1.image = nil
        tick2.image = nil
        tick3.image = nil
        tick4.image = nil
        switch (tag) {
        case 1:
            delegate?.selectedFilter(selectedFilter: .total_sales)
            tick1.image = UIImage(named: "check-mark")
        case 2:
            delegate?.selectedFilter(selectedFilter: .add_to_cart)
            tick2.image = UIImage(named: "check-mark")
        case 3:
            delegate?.selectedFilter(selectedFilter: .downloads)
            tick3.image = UIImage(named: "check-mark")
        case 4:
            delegate?.selectedFilter(selectedFilter: .user_sessions)
            tick4.image = UIImage(named: "check-mark")
        default:
            delegate?.selectedFilter(selectedFilter: .total_sales)
            tick1.image = UIImage(named: "check-mark")
        }
    }
    
    // Bottom popup attribute variables
    // You can override the desired variable to change appearance
    
    override var popupHeight: CGFloat { return height ?? CGFloat(300) }
    
    override var popupTopCornerRadius: CGFloat { return topCornerRadius ?? CGFloat(10) }
    
    override var popupPresentDuration: Double { return presentDuration ?? 1.0 }
    
    override var popupDismissDuration: Double { return dismissDuration ?? 1.0 }
    
    override var popupShouldDismissInteractivelty: Bool { return shouldDismissInteractivelty ?? true }
    
    override var popupDimmingViewAlpha: CGFloat { return BottomPopupConstants.kDimmingViewDefaultAlphaValue }
}
