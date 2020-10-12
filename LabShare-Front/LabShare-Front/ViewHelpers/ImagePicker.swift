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
            Text("Choose your profile picture")
            HStack{
                imageButton(image: "image1", showImagePicker: $showImagePicker, profileImage: $profileImage)
                
                imageButton(image: "image2", showImagePicker: $showImagePicker, profileImage: $profileImage)
                
                imageButton(image: "image3", showImagePicker: $showImagePicker, profileImage: $profileImage)
            }
            HStack{
                imageButton(image: "image4", showImagePicker: $showImagePicker, profileImage: $profileImage)
                
                imageButton(image: "image5", showImagePicker: $showImagePicker, profileImage: $profileImage)
                
                imageButton(image: "image6", showImagePicker: $showImagePicker, profileImage: $profileImage)
            }
            HStack{
                imageButton(image: "image7", showImagePicker: $showImagePicker, profileImage: $profileImage)
                
                imageButton(image: "image8", showImagePicker: $showImagePicker, profileImage: $profileImage)
                
                imageButton(image: "image9", showImagePicker: $showImagePicker, profileImage: $profileImage)
            }
        }
    }
}

struct ImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        ImagePicker(showImagePicker: Binding.constant(false), profileImage: Binding.constant("Hello"))
    }
}
