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
                ForEach(self.approveUsersVM.users, id: \.id) {
                    user in
                    ApprovalRowView(userVM: UserViewModel(user: user))
                }
                Spacer()
                
                
                
            }.padding()
        }
//        .onAppear(perform: {
//            self.searchVM.getUsersSearch(userAuthVM: userAuthVM, queryString: queryString)
//        })
        //        .onAppear(perform: {
        //            self.approveUsersVM.getUsersSearch(userAuthVM: userAuthVM, queryString: queryString)
        //        })
        //        .navigationBarTitle("")
        //        .navigationBarHidden(true)
        
        
        //        .navigationBarItems(trailing:
        //
        //        )
        
    }
}
    
    struct ApproveUsers_Previews: PreviewProvider {
        static var previews: some View {
            ApproveUsersView()
        }
    }
