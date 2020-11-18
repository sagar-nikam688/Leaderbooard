//
//  LeadsModel.swift
//  DemoApp
//
//  Created by Admin on 12/11/20.
//

import Foundation

struct LeadsModel: Codable {
    var apps: [AppsObject]?
}

struct AppsObject: Codable {
    var name, currency, money_format: String?
    var data: LeadsDataObject?
}

struct LeadsDataObject: Codable {
    var downloads, sessions ,total_sale, add_to_cart: StatsData?
}

struct StatsData: Codable {
    var total: Int?
    var month_wise: Month_wise?
}


struct Month_wise : Codable {
    var jan, feb, mar, apr, may, jun: Int?
}
