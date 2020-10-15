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
        ScrollView {
            VStack(alignment: .leading) {
                
                Text("Users to be approved:").font(Font.title)
                Divider()
                ForEach(self.approveUsersVM.users, id: \.user.id) {
                    userVM in
                    VStack (alignment: .leading, spacing: 5)  {
                        Divider()
                        Text("\(userVM.user.firstName) \(userVM.user.lastName)").bold()
                            .font(Font.title)
                        
                        Text("\(userVM.user.email)")
                        
                        HStack{
                            Button(action: {
                                userVM.user.isActive = true
                                userVM.updateIsActive(userAuthVM: userAuthVM)
                            }, label: {
                                Text("Approve")
                                    .foregroundColor(Color.white)
                                    .font(Font.headline.weight(.bold))
                            })
                            .padding(.vertical, 15)
                            .padding(.horizontal, 20)
                            .background(Color.green)
                            .cornerRadius(40)
                            
                            Button(action: {
                                userVM.deleteUser(userAuthVM: userAuthVM)
//                                if let index = approveUsersVM.users.firstIndex(of: userVM) {
//                                    approveUsersVM.users.remove(at: IndexSet(integer: self.index))
//                                }
                            }, label: {
                                Text("   Deny   ")
                                    .foregroundColor(Color.black)
                                    .font(Font.headline.weight(.bold))
                            })
                            .padding(.vertical, 15)
                            .padding(.horizontal, 20)
                            .background(Color.white)
                            .overlay(RoundedRectangle(cornerRadius: 40)
                                        .stroke(Color.black, lineWidth: 4))            }
                    }.padding()
                }
                Spacer()
                
                
                
            }.padding()
        }
        //        .onAppear(perform: {
        //            self.approveUsersVM.getNonAppproved(userAuthVM: userAuthVM)
        //        })
    }
}

struct ApproveUsers_Previews: PreviewProvider {
    static var previews: some View {
        ApproveUsersView()
    }
}
