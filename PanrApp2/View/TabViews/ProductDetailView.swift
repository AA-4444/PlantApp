//
//  ProductDetailView.swift
//  PanrApp2
//
//  Created by Алексей Зарицький on 17.07.2022.
//

import SwiftUI

struct ProductDetailView: View {
    var product: Product
    
    // For Matched Geometry effect...
    var animation: Namespace.ID
    
    // Shared Data Model...
    @EnvironmentObject var sharedData:  SharedDataModel
    
    @EnvironmentObject var homeData: HomeViewModel
    
    var body: some View {
        
        VStack{
            
            // Title Bar Product Image...
            VStack {
                
                // title Bar...
                HStack {
                    
                    Button {
                        // Closing View...
                        withAnimation(.easeInOut) {
                            sharedData.showDetailProduct = false
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(Color("green"))
                            .padding(15)
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.16), radius: 16, x: 4, y: 4)
                    }
                    
                    Spacer()
                    
                    Button {
                        addToLiked()
                    } label: {
                        Image("Liked")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(isLiked() ? .red :  Color.black.opacity(0.7))
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .padding(15)
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.16), radius: 16, x: 4, y: 4)
                            
                        
                    }
                    
                }
                .padding()
                
                // Product Image...
                // MARK: USE Matched Geometry effect.
                Image(product.productImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "\(product.id)IMAGE", in: animation)
                    .padding(.horizontal)
                    .offset(y: -12)
                    .frame(maxHeight: .infinity)
            }
            .frame(height: getRect().height / 2.7)
            .zIndex(1)
            
            // MARK: Product Details
            ScrollView(.vertical,showsIndicators: false) {
                
                // Product Data...
                VStack(alignment: .leading, spacing: 15) {
                    
                    Text(product.title)
                        .font(.system(size: 20).bold())
                    
                    Text(product.subtitle)
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                    
                    Text("Get gift for your green house")
                        .font(.system(size: 16).bold())
                        .padding(.top)
                    
                    Text("Available when you purchase plant indoor,outdoor or for garden.")
                        .font(.system(size: 15))
                        .foregroundColor(Color.gray)
                    
                    Button {
                        
                    } label: {
                        
                        // Since we need image right...
                        Label {
                            Image(systemName: "arrow.right")
                        } icon: {
                            Text("Full description")
                        }
                        .font(.system(size: 15).bold())
                        .foregroundColor(Color("green"))
                        .padding(10)
                        .padding(.horizontal)
                        .background(Color("BG"))
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.16), radius: 16, x: 4, y: 4)
                    }
                    
                    HStack {
                        
                        Text("Total:")
                            .font(.system(size: 17))
                        
                        Spacer()
                        
                        Text("\(product.price)")
                            .font(.system(size: 20).bold())
                            .foregroundColor(Color("Orange"))
                    }
                    .padding(.vertical,20)
                    
                    // ADD Button...
                    
                    Button {
                         addToCart()
                    } label: {
                        Text("\(isAddedToCart() ? "added" : "add") to basket")
                            .font(.system(size: 20).bold())
                            .foregroundColor(Color("green"))
                            .padding(.vertical,20)
                            .frame(maxWidth: .infinity)
                            .background(
                            
                                Color("BG")
                                    .cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.16), radius: 16, x: 4, y: 4)
                            )
                    }
                }
                .padding([.horizontal,.bottom],20)
                .padding(.top,25)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(
                Color.white
                // Corner Radius for top side...()
                    .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 25))
                    .ignoresSafeArea()
            )
            .zIndex(0)
        }
        .animation(.easeInOut, value: sharedData.likedProducts)
        .animation(.easeInOut, value: sharedData.cartProducts)
        .background(Color("BG").ignoresSafeArea())
    }
    
    func isLiked()->Bool{
        
        return sharedData.likedProducts.contains { product in
            return self.product.id == product.id
        }
    }
    
    func isAddedToCart()->Bool{
        
        return sharedData.cartProducts.contains { product in
            return self.product.id == product.id
        }
    }
    
    func addToLiked(){
        
        if let index = sharedData.likedProducts.firstIndex(where: { product in
            return self.product.id == product.id
        }){
            // Remove from liked...
            sharedData.likedProducts.remove(at: index)
        }
        else{
            // add to liked
            sharedData.likedProducts.append(product)
        }
    }
    
    func addToCart(){
        
        if let index = sharedData.cartProducts.firstIndex(where: { product in
            return self.product.id == product.id
        }){
            // Remove from liked...
            sharedData.cartProducts.remove(at: index)
        }
        else{
            // add to liked
            sharedData.cartProducts.append(product)
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Sample Product for Building Preview...
       // ProductDetailView(product: HomeViewModel().products[0])
       //     .environmentObject(SharedDataModel())
        
        MainPage()
    }
}
