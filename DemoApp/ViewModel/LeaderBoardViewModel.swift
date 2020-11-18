//
//  LeaderBoardViewModel.swift
//  DemoApp
//
//  Created by Admin on 12/11/20.
//

import Foundation
import Combine

class LeaderBViewModel {
    @Published private(set) var leaderResponse: LeadsModel?
    var errorBO = CurrentValueSubject<String?, Never>(nil)
    
    func fetchLeaderboardDetails() {
        APIClient.shared.getLeaderboardDetails { (status, error, responseModel) in
            if status {
                self.leaderResponse = responseModel
            } else {
//                self.errorBO = error
            }
        }
    }
}
