//
//  ImagePicker.swift
//  LabShare-Front
//
//  Created by Ananda Buckley on 5/10/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct ImagePicker: View {
    @Binding var showImagePicker: Bool
    @Binding var profileImage: String
    
    var body: some View {
        VStack {
            imageRow(image: "house", showImagePicker: $showImagePicker, profileImage: $profileImage)
            
            imageRow(image: "person", showImagePicker: $showImagePicker, profileImage: $profileImage)
            
            imageRow(image: "star", showImagePicker: $showImagePicker, profileImage: $profileImage)
        }
    }
}

struct ImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        ImagePicker(showImagePicker: Binding.constant(false), profileImage: Binding.constant("Hello"))
    }
}
