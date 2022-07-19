//
//  Home.swift
//  PanrApp2
//
//  Created by Алексей Зарицький on 14.07.2022.
//

import SwiftUI

struct Home: View {
    var animation: Namespace.ID
    
    // Shared Data...
    @EnvironmentObject var sharedData: SharedDataModel
    
    @StateObject var homeData: HomeViewModel = HomeViewModel()
    var body: some View {
       
        ScrollView(.vertical, showsIndicators: false) {
           
        VStack(spacing: 15){
            
            HStack(spacing: 15){
                HeaderView()
              }
            .padding(.vertical,12)
            .padding(.horizontal)
            .frame(width: getRect().width / 1)
            // .padding(.horizontal,25)
            
            // Products.tab...
            
            ScrollView(.horizontal, showsIndicators: false) {
                   
                HStack(spacing: 18){
                    
                    ForEach(ProductType.allCases,id: \.self){type in
                          
                        // Product Type View...
                          ProductTypeView(type: type)
                       }
                    }
                .padding(.horizontal,25)
                }
            .padding(.top,28)
            
            // Products Page...
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 25){
                      
                    ForEach(homeData.filteredProducts){product in
                           
                        // Product Card  View...
                        ProductCardView(product: product)
                        }
                    }
                .padding(.horizontal,25)
                .padding(.bottom)
                .padding(.top)
               
                }
            .padding(.top,30)
            
             // See More Button
            // Button will be show all product
            Button {
                homeData.showMoreProductsOnType.toggle()
            } label: {
                
                Label {
                     Image(systemName: "arrow.right")
                } icon: {
                    Text("see more")
                }
                .font(.system(size: 18).bold())
                .foregroundColor(Color("green"))
                .padding(10)
                .padding(.horizontal)
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.16), radius: 16, x: 4, y: 4)
              }
            .frame(maxWidth: .infinity,alignment: .trailing)
            .padding(.trailing)
            .padding(.top,10)
            }
        .padding(.vertical)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Color("BG"))
        // Updating Data when tab changes...
        .onChange(of: homeData.productType) {newValue in
            homeData.filterProductByType()
        }
        .sheet(isPresented: $homeData.showMoreProductsOnType) {
            
        } content: {
            MoreProductsView()
        }
    }
    
    @ViewBuilder
    func ProductCardView(product : Product)->some View{
        
        VStack(spacing: 10) {
            
          // matche Geometry Effect...
            ZStack {
                
                if sharedData.showDetailProduct{
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(0)
                }
                else{
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "\(product.id)IMAGE", in: animation)
                }
            }
                .frame(width: getRect().width / 2.5, height: getRect().width / 2.5)
            
            // Moving Image to Top...
                .offset(y: -80)
                .padding(.bottom,-80)
               
            
            Text(product.title)
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .padding(.top)
            
            Text(product.subtitle)
                .font(.system(size: 14))
                .foregroundColor(.gray)
            
            Text(product.price)
                .font(.system(size: 16))
                .fontWeight(.bold)
                .foregroundColor(Color("Orange"))
                .padding(.top,5)
                
        }
        .padding(.horizontal,20)
        .padding(.bottom,22)
        .background(
           
            Color.white
                .cornerRadius(25)
                .shadow(color: Color.black.opacity(0.16), radius: 1, x: 4, y: 4)
            
        )
        .padding(.top,80)
        // Showing Product detail when tapped
        .onTapGesture {
            
            withAnimation(.easeInOut) {
                sharedData.detailProduct = product
                sharedData.showDetailProduct = true
            }
        }
    }
    
    @ViewBuilder
    func ProductTypeView(type: ProductType)->some View{
        
        Button {
            //  updating Current Type...
            withAnimation{
                homeData.productType = type
            }
        } label: {
            
            Text(type.rawValue)
                .font(.system(size: 15))
                .fontWeight(.semibold)
                .foregroundColor(homeData.productType == type ? Color("Primary-1") : Color.gray)
                .padding(.bottom,10)
            // Adding Indicators in bottom
                .overlay(
               
                    
                    ZStack{
                        if homeData.productType == type{
                            Capsule()
                                .fill(Color("Primary-1"))
                                .matchedGeometryEffect(id: "PRODUCTTAB", in: animation)
                                .frame(height: 2)
                        }
                        else {
                            
                            Capsule()
                                .fill(Color.clear)
                                .frame(height: 2)
                        }
                    }
                        .padding(.horizontal,-5)
                    
                    ,alignment: .bottom
                )
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}


