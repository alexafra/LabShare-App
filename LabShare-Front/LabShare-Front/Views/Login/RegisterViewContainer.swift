//
//  RegisterViewContainer.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 27/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct RegisterViewContainer: View {
    @EnvironmentObject var userAuthVM: UserAuthenticationViewModel
    @EnvironmentObject var registerViewRouter: RegisterViewRouter
    
    var body: some View {
        VStack {
            if registerViewRouter.currentPage == RegisterRouterEnum.Register {
                RegisterView(userAuthVM: userAuthVM)
            } else if registerViewRouter.currentPage == RegisterRouterEnum.ProfileEdit {
                ProfileEditView(userId: userAuthVM.userAuth.id)
            } else if registerViewRouter.currentPage == RegisterRouterEnum.Login {
                LoginView(userAuthVM: userAuthVM)
            } else {
                Text("Hello World!")
            }
        }
    }
}

struct RegisterViewContainer_Previews: PreviewProvider {
    static var previews: some View {
        RegisterViewContainer().environmentObject(UserAuthenticationViewModel())
            .environmentObject(RegisterViewRouter())
    }
}
