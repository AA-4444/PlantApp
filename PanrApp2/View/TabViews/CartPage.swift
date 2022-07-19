//
//  CartPage.swift
//  PanrApp2
//
//  Created by Алексей Зарицький on 17.07.2022.
//

import SwiftUI

struct CartPage: View {
    // For Designing...
   
    @EnvironmentObject var sharedData: SharedDataModel
    
    // MARK: Delete options.
    @State var showDeleteOption: Bool = false
    
    var body: some View {
       
        NavigationView{
            
            VStack(spacing: 10) {
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack {
                        
                        HStack{
                            
                            Text("Basket")
                                .font(.system(size: 28).bold())
                                .foregroundColor(Color("Primary-1"))
                            
                            Spacer()
                            
                            Button {
                                withAnimation{
                                    showDeleteOption.toggle()
                                }
                            } label: {
                                Image("Delete")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25,height: 25)
                                    //.padding(15)
                                    .padding(.horizontal,20)
                                    .padding(.vertical,15)
                                    .background(Color.white)
                                    .cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.16), radius: 16, x: 4, y: 4)
                            }
                            .opacity(sharedData.cartProducts.isEmpty ? 0 : 1)
                        }
                        
                        if sharedData.cartProducts.isEmpty{
                            
                            Group{
                                Image(systemName: "flame")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(Color("Orange"))
                                    .padding()
                                    .padding(.top,35)
                                
                                Text("No items added")
                                    .font(.system(size: 25))
                                    .fontWeight(.semibold)
                                     
                                Text("Hit the add button to save into basket.")
                                    .font(.system(size: 18))
                                    .foregroundColor(Color.gray)
                                    .padding(.horizontal)
                                    .padding(.top,10)
                                    .multilineTextAlignment(.center)
                                
                            }
                        }
                        else{
                            
                            // Displaying Products...
                            VStack(spacing: 15) {
                                
                                ForEach($sharedData.cartProducts){$product in
                                    
                                    HStack(spacing: 0) {
                                        
                                        if showDeleteOption{
                                            
                                            Button {
                                                deleteProduct(product: product)
                                            } label: {
                                                Image(systemName: "minus.circle.fill")
                                                    .font(.title2)
                                                    .foregroundColor(Color("Orange"))
                                            }
                                            .padding(.trailing)
                                        }
                                        
                                        CardView(product: $product)
                                    }
                                }
                            }
                            .padding(.top,25)
                            .padding(.horizontal)
                        }
                    }
                    .padding()
                }
                
                // Showing total and check out button...
                if !sharedData.cartProducts.isEmpty {
                    
                    Group{
                        
                        HStack{
                            
                            Text("Total")
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text(sharedData.getTotalPrice())
                                .font(.system(size: 18).bold())
                                .foregroundColor(Color("green"))
                        }
                        
                        
                        Button {
                            
                        } label: {
                            
                            Text("Checkout")
                                .font(.system(size: 18).bold())
                                .foregroundColor(Color("green"))
                                .padding(.vertical,18)
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
                                
                        }
                        .padding(.vertical)
                    }
                    .padding(.horizontal,25)
                }
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
            
                Color("BG")
                    .ignoresSafeArea()
            )
        }
    }
    
    func deleteProduct(product: Product) {
        
        if let index = sharedData.cartProducts.firstIndex(where: { currentProduct in
            return product.id == currentProduct.id
        }){
            
            let _ = withAnimation{
                sharedData.cartProducts.remove(at: index)
            }
        }
    }
}


struct CartPage_Previews: PreviewProvider {
    static var previews: some View {
        CartPage()
    }
}

struct CardView: View{
    
    @Binding var product: Product
    
    var body: some View{
        
        HStack(spacing: 15) {
            
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 8){
                
                Text(product.title)
                    .font(.system(size: 18).bold())
                    .lineLimit(1)
                
                Text(product.subtitle)
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                    .foregroundColor(Color("green"))
                
             // MARK: Quanity Buttons...
                HStack(spacing: 10) {
                    
                    Text("Quanity")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    
                    Button {
                        product.quantity = (product.quantity > 0 ? (product.quantity - 1) : 0)
                    } label: {
                        Image(systemName: "minus")
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(width: 20,height: 20)
                            .background(Color("Orange"))
                            .cornerRadius(4)
                    }
                    
                    Text("\(product.quantity)")
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Button {
                        product.quantity += 1
                    } label: {
                        Image(systemName: "plus")
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(width: 20,height: 20)
                            .background(Color("Orange"))
                            .cornerRadius(4)
                    }
                }
            }
        }
        .padding(.horizontal,10)
        .padding(.vertical,10)
        .frame(maxWidth: .infinity,alignment: .leading)
        .background(
          
            Color.white
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.16), radius: 16, x: 4, y: 4)
        )
    }
}
