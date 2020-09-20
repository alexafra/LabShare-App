//
//  myProfileView.swift
//  LabShare-Front
//
//  Created by Ananda Buckley on 6/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct ProfileContainerView: View {
    @EnvironmentObject var userAuthVM: UserAuthenticationViewModel
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    ProfileView(userId: self.userAuthVM.userAuth.id)
                        .navigationBarTitle(Text(""), displayMode: .inline)
                        .navigationBarItems(trailing: SearchBarView())
                }
                
                    
    //
    //                .edgesIgnoringSafeArea(.top)
            }
        }
        
        
//        .inline()
//        .navigationBarHidden(true)
    }
}

struct ProfileContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileContainerView().environmentObject(UserAuthenticationViewModel(id: 3, token: "a1955fcbf50b1eda4a829f7e6a21a1a34fcb5e73", isLoggedIn: true))
    }
}
