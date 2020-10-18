//
//  ProfileSettings.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 28/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI
import Combine

struct ProfileSettingsView: View {
    //    @State var userId: Int
    @ObservedObject var profileVM: ProfileViewModel
    @EnvironmentObject var userAuthVM: UserAuthenticationViewModel
    @State private var showingDeleteAlert = false
    @State private var showingAddAdminAlert = false
    @State private var showingRemoveAdminAlert = false
    @State private var showingLogOutAlert = false
    @State private var showDetail = false
    
    var body: some View {
        VStack {
            List {
                NavigationLink(destination: ProfileEditView(userId: self.profileVM.userId, showSelf: $showDetail), isActive: $showDetail) {
                    HStack {
                        Image(systemName: "pencil")
                        Text("Edit Profile")
                    }
                }.buttonStyle(PlainButtonStyle())
                
//                if (self.userAuthVM.userAuth.isStaff && self.userAuthVM.userAuth.id == self.profileVM.profile.owner.id) {
                if (self.userAuthVM.userAuth.isStaff) {
                    NavigationLink(
                        destination: ApproveUsersView(userAuthVM: _userAuthVM),
                        label: {
                            HStack {
                                Image(systemName: "plus")
                                Text("Approve Users")
                            }
                    }).buttonStyle(PlainButtonStyle())
                }
                
                
                if (self.userAuthVM.userAuth.isStaff && self.profileVM.profile.owner.isStaff) {
                    Button(action: {
                        self.showingRemoveAdminAlert = true
                    }, label: {
                        HStack {
                            Image(systemName: "bin.xmark.fill")
                            Text("Remove Admin")
                        }
                    }).alert(isPresented: $showingRemoveAdminAlert) {
                        Alert(title: Text("Remove User Admin"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Remove")) {
                            self.profileVM.removeAdmin(userAuthVM: self.userAuthVM)
                        }, secondaryButton: .cancel())
                    }
                }
                if (self.userAuthVM.userAuth.isStaff && !self.profileVM.profile.owner.isStaff) {
                    Button(action: {
                        self.showingAddAdminAlert = true
                    }) {
                        HStack {
                            Image(systemName: "book")
                            Text("Make Admin")
                        }
                    }.alert(isPresented: $showingAddAdminAlert) {
                        Alert(title: Text("Make User Admin"), message: Text("Are you sure?"), primaryButton: .default(Text("Make Admin")) {
                            self.profileVM.setAdmin(userAuthVM: self.userAuthVM)
                        }, secondaryButton: .cancel())
                    }
                }
                Button(action: {
                    self.showingDeleteAlert = true
                }, label: {
                    HStack {
                        Image(systemName: "trash")
                        Text("Delete User")
                    }
                }).alert(isPresented: $showingDeleteAlert) {
                    Alert(title: Text("Delete User"), message: Text("Are you sure? \nThis will delete all of their posts and comments."), primaryButton: .destructive(Text("Delete")) {
                        self.profileVM.deleteProfile(userAuthVM: self.userAuthVM)
                        if (self.userAuthVM.userAuth.id == profileVM.profile.owner.id) {
                            self.userAuthVM.userAuth.isLoggedIn = false
                        } else {
                            //DO SOMETHING TO MAKE VIEW WORK
                        }
                    }, secondaryButton: .cancel())
                }
                
                Button(action: {
                    self.showingLogOutAlert = true
                }, label: {
                    HStack{
                        Image(systemName: "escape")
                        Text("Log Out")
                    }
                }).alert(isPresented: $showingLogOutAlert) {
                    Alert(title: Text("Log Out"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Log Out")) {
                        userAuthVM.userAuth.isLoggedIn = false
                    }, secondaryButton: .cancel()
                )
            }.navigationBarTitle(Text("Settings"), displayMode: .inline)
            }
        }
    }
}

struct ProfileSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileSettingsView(profileVM: ProfileViewModel(userId: 76))
                .environmentObject(UserAuthenticationViewModel(id: 76, token: "e6d3868c84c0cb418cb676d3fca4d9a9d03c90d8", isLoggedIn: true, isStaff: true, isActive: true))
        }
        
    }
}
