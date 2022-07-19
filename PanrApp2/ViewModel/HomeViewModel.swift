//
//  HomeViewModel.swift
//  PanrApp2
//
//  Created by Алексей Зарицький on 15.07.2022.
//

import SwiftUI

import Combine

class HomeViewModel: ObservableObject{
     
    @Published var productType: ProductType = .Indoor
    
    //Sample Products...
    @Published var products: [Product] = [

        Product(type: .Indoor, title: "Snake Plant", subtitle: "Plant", price: "$80",productImage: "Plant"),
        Product(type: .Indoor, title: "Dragon Plant", subtitle: "Plant", price: "$100", productImage: "Plant-1"),
        Product(type: .Indoor, title: "Strange Plant", subtitle: "Plant", price: "$86", productImage: "Plant-2"),
        Product(type: .Outdoor, title: "Flower Plant", subtitle: "Plant", price: "$50", productImage: "Plant-3"),
        Product(type: .Outdoor, title: "Palm Tree", subtitle: "Tree", price: "$200", productImage: "Plant-4"),
        Product(type: .Outdoor, title: "Palm Plant", subtitle: "Plant", price: "$180", productImage: "Plant-5"),
        Product(type: .Garden, title: "Snake Plant", subtitle: "Plant", price: "$80",productImage: "Plant"),
        Product(type: .Garden, title: "Dragon Plant", subtitle: "Plant", price: "$100", productImage: "Plant-1"),
        Product(type: .Garden, title: "Strange Plant", subtitle: "Plant", price: "$86", productImage: "Plant-2"),

    ]
    
    // Filtered Products...
    @Published var filteredProducts: [Product] = []
    
    // More products on the type..
    @Published var showMoreProductsOnType: Bool = false
    
    // Search Data...
    @Published var searchText: String = ""
    @Published var searchActivated: Bool = false
    @Published var searchedProducts: [Product]?
    
    var searchCancellable: AnyCancellable?
    
    init(){
        filterProductByType()
        
        searchCancellable = $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str != ""{
                    self.filterProductBySearch()
                }
                else{
                    self.searchedProducts = nil
                }
            })
    }
    
    func filterProductByType(){
        
        // Filtering Product By Product Type...
        DispatchQueue.global(qos: .userInteractive).async {
            
            let results = self.products
            // Since it will require more memory so were using lazy to perform more...
                .lazy
                .filter { product in
                    
                    return product.type == self.productType
                }
            // Limiting result...
                .prefix(4)
            
            DispatchQueue.main.async {
                
                self.filteredProducts = results.compactMap({ product in
                    return product
                })
            }
        }
    }
    
    func filterProductBySearch(){
        
        // Filtering Product By Product Type...
        DispatchQueue.global(qos: .userInteractive).async {
            
            let results = self.products
            // Since it will require more memory so were using lazy to perform more...
                .lazy
                .filter { product in
                    
                    return product.title.lowercased().contains(self.searchText.lowercased())
                }
            
            DispatchQueue.main.async {
                
                self.searchedProducts = results.compactMap({ product in
                    return product
                })
            }
        }
    }
}



