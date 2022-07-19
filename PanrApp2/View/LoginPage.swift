//
//  LoginPage.swift
//  PanrApp2
//
//  Created by Алексей Зарицький on 08.07.2022.
//

import SwiftUI

struct LoginPage: View {
    @StateObject var loginData: LoginPageModel = LoginPageModel()
    var body: some View {
        
        VStack {
            // Welcome Back text for 3 half screen...
            Text("Welcome \nback")
                .font(.system(size: 55))
                .foregroundColor(Color.white)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity,alignment: .leading)
                .frame(height: getRect().height / 3.5)
                .padding()
            
            ScrollView(.vertical, showsIndicators: false) {
                   
                // login Page Form...
                VStack(spacing: 15) {
                    
                    Text(loginData.registerUser ? "Register" :  "Login")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity,alignment: .leading)
                         
                    // Custom text Fields
                    
                    CustomTextField(icon: "envelope", title: "Email", hint: "example@gmail.com", value: $loginData.email, showPassword: .constant(false))
                        .padding(.top,30)
                    
                    CustomTextField(icon: "lock", title: "Password", hint: "123456", value: $loginData.password, showPassword: $loginData.showPassword)
                        .padding(.top,10)
                    
                   // Register Reenter Password
                    if loginData.registerUser{
                        CustomTextField(icon: "envelope", title: "Re-Enter Password", hint: "123456", value: $loginData.re_Enter_Password, showPassword: $loginData.showReEnterPassword)
                            .padding(.top,10)
                    }
                    
                    // forgot password button...
                    Button {
                        loginData.ForgotPassword()
                    } label: {
                        
                        Text("Forgot password ?")
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Primary"))
                    }
                    .padding(.top,8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Login Button...
                    Button {
                        if loginData.registerUser{
                            loginData.Register()
                        }
                        else {
                            loginData.Login()
                        }
                    } label: {
                        
                        Text("Login")
                            .font(.system(size: 17).bold())
                            .padding(.vertical,20)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color("Primary"))
                            .background(Color.white)
                            .cornerRadius(18)
                            .shadow(color: Color.black.opacity(0.1), radius: 5,x: 5,y: 5)
                    }
                    .padding(.top,25)
                    .padding(.horizontal)
                    
                    // Register User Button....
                    
                    Button {
                        withAnimation{
                            loginData.registerUser.toggle()
                        }
                    } label: {
                        
                        Text(loginData.registerUser ? "Back to login" : "Creat account")
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Primary"))
                    }
                    .padding(.top,8)
                  }
                .padding(30)
               }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color("BG")
                // Aplying Custom Corners...
                    .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 25))
                    .ignoresSafeArea()
               )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("green"))
        
        // Clearing data when changes...
        //Optional...
        .onChange(of: loginData.registerUser) { newValue in
            
            loginData.email = ""
            loginData.password = ""
            loginData.re_Enter_Password = ""
            loginData.showPassword = false
            loginData.showReEnterPassword = false
        }
    }
    
    @ViewBuilder
    func CustomTextField(icon: String,title: String,hint: String,value: Binding<String>,showPassword: Binding<Bool>)->some View{
        
        VStack(alignment: .leading, spacing: 12){
            
            Label {
                Text(title)
                    .font(.system(size: 14))
            } icon: {
                Image(systemName: icon)
            }
            .foregroundColor(Color.black.opacity(0.8))
            
            if title.contains("Password") && !showPassword.wrappedValue{
                SecureField(hint, text: value)
                    .padding(.top,2)
            } else {
                TextField(hint, text: value)
                    .padding(.top,2)
            }
            
            Divider()
                .background(Color.black.opacity(0.4))
        }
        // Showing Show Button for password Field...
        .overlay(
            
            Group {
                if title.contains("Password"){
                    Button(action: {
                        showPassword.wrappedValue.toggle()
                    }, label: {
                        Text(showPassword.wrappedValue ? "Hide" : "Show")
                            .font(.system(size: 13))
                            .foregroundColor(Color("Primary"))
                    })
                    .offset(y: 8)
                }
            }
            
           , alignment: .trailing
        )
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
