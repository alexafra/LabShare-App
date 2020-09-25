//
//  ViewHelpers.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 23/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct TextFieldAuthorization: ViewModifier {
//    typealias Body = <#type#>
    
    func body(content: Content) -> some View {
        content
            .padding(20)
            .autocapitalization(.none)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.green, lineWidth: 1)
                    .shadow(radius:5))
            .padding(.top, 10)
            
    }
}

struct TextError: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.footnote)
            .foregroundColor(.red)
            
    }
}

struct HiddenTextError: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.footnote)
            .foregroundColor(.white)
            
    }
}

struct AuthButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 15)
            .padding(.horizontal, 40)
            .background(Color.green)
            .cornerRadius(40)
            .padding(.vertical, 10)
            
    }
}

struct ViewHelpers_Previews: PreviewProvider {
//    @State var value: String
    static var previews: some View {
        VStack {
            /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/.modifier(TextFieldAuthorization())
            /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/.modifier(TextError())
            Button(action: {
            }) {
                Text("Register")
                    .foregroundColor(Color.white)
                    .font(Font.title.weight(.bold))
            }.modifier(AuthButton())
        }.padding(20)
        
    }
}

