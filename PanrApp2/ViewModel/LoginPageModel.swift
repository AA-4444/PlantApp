//
//  LoginPageModel.swift
//  PanrApp2
//
//  Created by Алексей Зарицький on 08.07.2022.
//


import SwiftUI

class LoginPageModel: ObservableObject {
   
    // login properties...
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    
    // Register Properties
    @Published var registerUser: Bool = false
    @Published var re_Enter_Password: String = ""
    @Published var showReEnterPassword: Bool = false
    
    // Log Status...
    @AppStorage("log_Status") var log_Status: Bool = false
    
    // Login Call...
    func Login(){
        //Do Action Here...
        withAnimation{
            log_Status = true
        }
    }
    
    func Register(){
        // Do action here...
        withAnimation{
            log_Status = true
        }
    }
    
    func ForgotPassword(){
        // Do Action here...
    }
}

