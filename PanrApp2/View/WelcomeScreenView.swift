//
//  WelcomeScreenView.swift
//  PanrApp2
//
//  Created by Алексей Зарицький on 08.07.2022.
//

import SwiftUI

struct WelcomeScreenView: View {
    // Showing Login Page...
    @State var showLoginPage: Bool = false
    var body: some View {
        
        VStack(alignment: .leading){
            
            Text("Make Your")
                .font(.title)
                .fontWeight(.light)
                .foregroundColor(.white)
                .padding(.top,20)
                .padding(.horizontal,20)
            
           Text("Green House")
               .font(.largeTitle)
               .foregroundColor(.white)
                .fontWeight(.semibold)
                .padding(.horizontal,20)
            
            Spacer()
            
            Button {
                withAnimation{
                    showLoginPage = true
                }
            } label: {
                
                Text("Next")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(18)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                    .foregroundColor(Color("Primary"))
            }
            .padding(.horizontal,30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("2")
                .resizable()
            //.aspectRatio(contentMode: .fit)
                .overlay(LinearGradient(colors: [Color.black.opacity(0.45), Color.black.opacity(0.95)], startPoint: .topLeading, endPoint: .bottomLeading))
                .ignoresSafeArea()
        )
        .overlay(
        
            Group{
                if showLoginPage{
                    LoginPage()
                        .transition(.move(edge: .bottom))
                }
            }
        )
    }
}

struct WelcomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreenView()
    }
}


extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}
