//
//  ContentView.swift
//  PanrApp2
//
//  Created by Алексей Зарицький on 08.07.2022.
//

import SwiftUI

struct ContentView: View {
     // log Status...
    @AppStorage("log_Status") var log_Status: Bool = false
    var body: some View {
        Group{
            if log_Status{
                MainPage()
            }
            else {
                WelcomeScreenView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
