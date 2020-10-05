//
//  imageRow.swift
//  LabShare-Front
//
//  Created by Ananda Buckley on 5/10/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct imageRow: View {
    @State var image: String
    @Binding var showImagePicker: Bool
    @Binding var profileImage: String
    
    var body: some View {
        HStack {
            
            Button(action: {
                    profileImage = image
                    self.showImagePicker = false }) {
                CircleImage(imageName: image, imageCol: .black)
            }
            Button(action: {
                    profileImage = image
                    self.showImagePicker = false }) {
                CircleImage(imageName: image, imageCol: .red)
            }
            Button(action: {
                    profileImage = image
                    self.showImagePicker = false }) {
                CircleImage(imageName: image, imageCol: .blue)
            }
        }
    }
}

struct imageRow_Previews: PreviewProvider {
    static var previews: some View {
        imageRow(image: "person", showImagePicker: Binding.constant(false), profileImage: Binding.constant("person"))
    }
}
