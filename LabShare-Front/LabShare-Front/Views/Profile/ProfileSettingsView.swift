//
//  ProfileSettings.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 28/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct ProfileSettingsView: View {
    @State var userId: Int
    
    var body: some View {
        VStack {
            List {
                NavigationLink(destination: ProfileEditView(userId: self.userId)) {
                    HStack {
                        Image(systemName: "pencil")
                        Text("Edit Profile")
                    }
                }.buttonStyle(PlainButtonStyle())
                HStack {
                    Image(systemName: "trash")
                        .imageScale(.large)
                    Text("Delete Profile")
                }
            }
        }.navigationBarTitle(Text("Settings"), displayMode: .inline)
        
    }
}

struct ProfileSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSettingsView(userId: 37)
    }
}
