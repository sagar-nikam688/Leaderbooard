//
//  ViewController.swift
//  DemoApp
//
//  Created by Admin on 12/11/20.
//

import UIKit
import Combine

enum SortBy: String {
    case total_sales = "Total Sales"
    case add_to_cart = "Add to Cart"
    case downloads = "Downloads"
    case user_sessions = "User Sessions"
}

class LeaderBoardViewController: UIViewController {
    // MARK: @IBOutlet and variable intitialization

    @IBOutlet weak var leaderboardTableview: UITableView!
    @IBOutlet weak var sortByButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    private var cancellables: Set<AnyCancellable> = []

    var leaderboardVM = LeaderBViewModel()
    var datasource: [AppsObject]? = []
    var selectedFilter: SortBy = .total_sales
    // MARK: Lisfe Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        bindViewModel()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        leaderboardVM.fetchLeaderboardDetails()
    }
    
    @IBAction func sortBYAction(_ sender: Any) {
        guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "SortByViewController") as? SortByViewController else { return }
        popupVC.height = 250
        popupVC.topCornerRadius = 10
        popupVC.presentDuration = 0.5
        popupVC.dismissDuration = 0.5
        popupVC.shouldDismissInteractivelty = true
        popupVC.delegate = self
        popupVC.selectedState = self.selectedFilter
        present(popupVC, animated: true, completion: nil)

    }
    
    fileprivate func setUp() {
        let nib = UINib(nibName: "StatesTableViewCell", bundle: nil)
        leaderboardTableview.register(nib, forCellReuseIdentifier: "StatesTableViewCell")
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }

    private func bindViewModel() {
        leaderboardVM.$leaderResponse.sink { [weak self] responseObject in
            DispatchQueue.main.async {
                self?.datasource = responseObject?.apps
                self?.sortDatasourceArray(sortBy: .total_sales)
            }
        }.store(in: &cancellables)
    }
    
    private func sortDatasourceArray(sortBy: SortBy) {
        switch sortBy {
        case .downloads:
            datasource?.sort {
                $0.data?.downloads?.total ?? 0 < $1.data?.downloads?.total ?? 0
            }
        case .add_to_cart:
            datasource?.sort {
                $0.data?.add_to_cart?.total ?? 0 < $1.data?.add_to_cart?.total ?? 0
            }
            
        case .total_sales:
            datasource?.sort {
                $0.data?.total_sale?.total ?? 0 < $1.data?.total_sale?.total ?? 0
            }
        case .user_sessions:
            datasource?.sort {
                $0.data?.sessions?.total ?? 0 < $1.data?.sessions?.total ?? 0
            }
        }
        self.leaderboardTableview.reloadData()
        self.leaderboardTableview.isHidden = false
        self.activityIndicator.stopAnimating()
    }

}

extension LeaderBoardViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.leaderboardTableview.dequeueReusableCell(withIdentifier: "StatesTableViewCell", for: indexPath) as? StatesTableViewCell else {
            return UITableViewCell()
        }
        cell.item = self.datasource?[indexPath.row]
        cell.selectedFilter = self.selectedFilter
        return cell
    }

}

extension LeaderBoardViewController: sortByFilterDelegate {
    func selectedFilter(selectedFilter: SortBy) {
        self.selectedFilter = selectedFilter
        self.sortDatasourceArray(sortBy: selectedFilter)
    }
}
