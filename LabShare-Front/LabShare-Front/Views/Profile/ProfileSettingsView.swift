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
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    
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
                    Button(action: {
                            self.showingDeleteAlert = true
                    }) {
                        HStack {
                            Image(systemName: "trash")
                            Text("Delete User")
                        }
                    }.alert(isPresented: $showingDeleteAlert) {
                        Alert(title: Text("Delete User"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete")) {
                            self.profileVM.deleteProfile(userAuthVM: self.userAuthVM)
                            self.presentationMode.wrappedValue.dismiss()
                            self.presentationMode.wrappedValue.dismiss()
                            }, secondaryButton: .cancel()
                        )
                    
                }
            }
        }.navigationBarTitle(Text("Settings"), displayMode: .inline)
        
    }
}
}

struct ProfileSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileSettingsView(profileVM: ProfileViewModel(userId: 70))
                .environmentObject(UserAuthenticationViewModel(id: 70, token: "356a0facdfb32b8720ada293893c4dae6267d406", isLoggedIn: true))
        }
        
    }
}
