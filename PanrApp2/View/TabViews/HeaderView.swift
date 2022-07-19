//
//  HeaderView.swift
//  PanrApp2
//
//  Created by Алексей Зарицький on 15.07.2022.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            VStack (alignment: .leading){
                Text("Exclusive Plants")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("for your hobby")
                    .font(.title)
            }
            .foregroundColor(Color("Primary-1"))
            Spacer()
            Image(systemName: "person.circle")
                .resizable()
                .foregroundStyle(Color("green"))
                .frame(width: 40,height: 40)
        }
    }
}
