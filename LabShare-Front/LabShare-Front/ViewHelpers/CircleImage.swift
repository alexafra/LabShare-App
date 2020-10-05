//
//  CircleImage.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 20/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI
import Combine

struct CircleImage: View {
    @State var imageName: String = "person"
    @State var imageCol: Color = .black
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
            .padding(5)
            .foregroundColor(imageCol)
            
    }
}

struct CircleImageUpdatable: View {
    @Binding var imageName: String
    @State var imageCol: Color = .black
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
            .padding(5)
            .foregroundColor(imageCol)
            
    }
}



struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
