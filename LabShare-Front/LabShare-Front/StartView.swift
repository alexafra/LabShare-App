//
//  StartView.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 19/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

/*
 Want to Look at creating a new ViewModel for ProfileView
 Somehow avoid passing userId down everywhere - feels like a waste
 
 
 
 */

import SwiftUI

struct StartView: View {
    @EnvironmentObject var userAuthVM: UserAuthenticationViewModel
    //Check if id = -1 OR token is empty for now, in future, may want to hit api to confirm valid token
    var body: some View {
        VStack {
            if self.userAuthVM.userAuth.isLoggedIn == false {
                SetUpView()
            } else {
                ContainerView()
            }
        }
        
    }
}

struct StartView_Previews: PreviewProvider {
    
    static var previews: some View {
        StartView()
            .environmentObject(UserAuthenticationViewModel(id: 1, token: "e3ef7d0655f1698e348a81eb184156b74612ad59", isLoggedIn: false))
    }
}
