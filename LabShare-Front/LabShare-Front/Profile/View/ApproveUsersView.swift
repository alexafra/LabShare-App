//
//  ApproveUsers.swift
//  LabShare-Front
//
//  Created by Ananda Buckley on 15/10/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct ApproveUsersView: View {
    @EnvironmentObject var userAuthVM: UserAuthenticationViewModel
    @ObservedObject var approveUsersVM: ApproveUsersViewModel = ApproveUsersViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
            
                
                Text("Users to be approved:").font(Font.title)
                Divider()
                ForEach(self.approveUsersVM.users, id: \.user.id) {
                    userVM in
                    VStack {
                        HStack {
                            Text("\(userVM.user.firstName) \(userVM.user.lastName)").bold()
                                .font(Font.title)
                            Spacer()
                            
                            Button(action: {
                                userVM.user.isActive = true
                                userVM.updateIsActive(userAuthVM: userAuthVM)
                                if let index = self.approveUsersVM.users.firstIndex(of: userVM) {
                                    self.approveUsersVM.users.remove(at: index)
                                }
                            }, label: {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.green)
                                    .font(Font.title.weight(.bold))
    //                                Text("Approve")
    //                                    .foregroundColor(Color.white)
    //                                    .font(Font.headline.weight(.bold))
                            }).padding(.trailing)
    //                            .padding(.vertical, 15)
    //                            .padding(.horizontal, 20)
    //                            .background(Color.green)
    //                            .cornerRadius(40)
    //
                            Button(action: {
                                userVM.deleteUser(userAuthVM: userAuthVM)
                                if let index = self.approveUsersVM.users.firstIndex(of: userVM) {
                                    self.approveUsersVM.users.remove(at: index)
                                }
                                
                            }, label: {
                                Image(systemName: "x.circle.fill")
                                    .foregroundColor(.red)
                                    .font(Font.title.weight(.bold))
    //                                Text("   Deny   ")
    //                                    .foregroundColor(Color.black)
    //                                    .font(Font.headline.weight(.bold))
                            }).padding(.leading)
    //                            .padding(.vertical, 15)
    //                            .padding(.horizontal, 20)
    //                            .background(Color.white)
    //                            .overlay(RoundedRectangle(cornerRadius: 40)
    //                            .stroke(Color.black, lineWidth: 4))
                        }
                        Divider()
                    }.padding()
                }
                Spacer()
            }.padding()
        }
        .onAppear(perform: self.approveUsersVM.getAllNonApprovedClosure(userAuthVM: userAuthVM))
        
    }
}

struct ApproveUsers_Previews: PreviewProvider {
    static var previews: some View {
        ApproveUsersView()
            .environmentObject(UserAuthenticationViewModel(id: 80, token: "d620ebc3ca80b02814afd8be67f6c815cca2296c", isLoggedIn: true, isStaff: true, isActive: true))
    }
}

