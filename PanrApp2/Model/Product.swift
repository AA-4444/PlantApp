//
//  Product.swift
//  PanrApp2
//
//  Created by Алексей Зарицький on 15.07.2022.
//

import SwiftUI

// Product Model...
struct Product: Identifiable,Hashable {
    var id = UUID().uuidString
    var type: ProductType
    var title: String
    var subtitle: String
    var description: String = ""
    var price: String
    var productImage: String = ""
    var quantity: Int = 1
}


// Prodcuts Types..
enum ProductType: String,CaseIterable{
  //  case ALL = "ALL"
    case Indoor = "Indoor"
    case Outdoor = "Outdoor"
    case Garden = "Garden"
}
