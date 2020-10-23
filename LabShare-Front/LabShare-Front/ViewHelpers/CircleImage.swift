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
    @State var imageName: String = "image1"
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 2))
            .shadow(radius: 10)
            .padding(5)
            
    }
}

struct CircleImageUpdatable: View {
    @Binding var imageName: String
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 2))
            .shadow(radius: 10)
            .padding(5)
            
    }
}



struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
