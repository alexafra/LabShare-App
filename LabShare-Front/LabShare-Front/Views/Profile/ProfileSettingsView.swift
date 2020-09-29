//
//  ProfileSettings.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 28/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct ProfileSettingsView: View {
//    @State var userId: Int
    @ObservedObject var profileVM: ProfileViewModel
    @EnvironmentObject var userAuthVM: UserAuthenticationViewModel
    
    var body: some View {
        VStack {
            List {
                NavigationLink(destination: ProfileEditView(userId: self.profileVM.userId)) {
                    HStack {
                        Image(systemName: "pencil")
                        Text("Edit Profile")
                    }
                }.buttonStyle(PlainButtonStyle())
                HStack {
                    Button(action: self.profileVM.deleteProfileClosure(userAuthVM: userAuthVM)) {
                        HStack {
                            Image(systemName: "trash")
                            Text("Delete User")
                        }
                    }
                    
                }
            }
        }.navigationBarTitle(Text("Settings"), displayMode: .inline)
        
    }
}

struct ProfileSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSettingsView(profileVM: ProfileViewModel(userId: 37))
            .environmentObject(UserAuthenticationViewModel(id: 37, token: "14f2518e6ffc20cf52642b7c7d51b63b88fe127f", isLoggedIn: true))
    }
}
