//
//  PostSettingsView.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 28/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct PostSettingsView: View {
    @State var userId: Int
    @State var postId: Int
    
    var body: some View {
        VStack {
            List {
                NavigationLink(destination: PostEditView(userId: self.userId, postId: self.postId)) {
                    HStack {
                        Image(systemName: "pencil")
                        Text("Edit Post")
                    }
                }.buttonStyle(PlainButtonStyle())
                HStack {
                    Image(systemName: "trash")
                        .imageScale(.large)
                    Text("Delete Post")
                }
            }
        }.navigationBarTitle(Text("Settings"), displayMode: .inline)
        
    }
}

struct PostSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSettingsView(userId: 37)
    }
}
