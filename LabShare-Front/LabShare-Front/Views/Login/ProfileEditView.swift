//
//  ProfileSetupView.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 23/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct ProfileEditView: View {
    @EnvironmentObject var userAuthVM: UserAuthenticationViewModel
    //    @Enviro var registerViewRouter: RegisterViewRouter
    @ObservedObject var profileVM: ProfileViewModel

    
    init(userId: Int) {
        self.profileVM = ProfileViewModel(userId: userId)
//        self.registerViewRouter = registerViewRouter
    }
//    init(userAuthVM: UserAuthenticationViewModel, firstName: String, lastName: String) {
//        self.profileVM = ProfileViewModel(userId: userAuthVM.userAuth.id, userAuthVM: userAuthVM, firstName: firstName, lastName: lastName)
//    }
    
    var body: some View {
        VStack {
            VStack(alignment: .center) {
//                Text("\(profileVM.profile.owner.firstName) \(profileVM.profile.owner.lastName)")
//                    .font(.largeTitle)
//                    .fontWeight(.semibold)
                VStack(alignment: .leading) {
                    Text("dob:")
                    TextField("dob", text: self.$profileVM.profile.dob)
                        .modifier(TextFieldAuthorization())
                }.frame(minHeight: 0, maxHeight: .infinity)
            
                VStack(alignment: .leading) {
                    Text("occupation:")
                    TextField("occupation", text: self.$profileVM.profile.occupation)
                        .modifier(TextFieldAuthorization())
                }.frame(minHeight: 0, maxHeight: .infinity)
                VStack(alignment: .leading) {
                    Text("employer:")
                    TextField("employer", text: self.$profileVM.profile.employer).modifier(TextFieldAuthorization())
                }.frame(minHeight: 0, maxHeight: .infinity)
        
                VStack(alignment: .leading) {
                    Text("bio:")
                    TextField("bio", text: self.$profileVM.profile.bio)
                        .modifier(TextFieldAuthorization())
                }.frame(minHeight: 0, maxHeight: .infinity)
                Button(action: {
                    self.profileVM.updateProfile(userAuthVM: userAuthVM)
                }) {
                    Text("Save")
                        .foregroundColor(Color.white)
                        .font(Font.title.weight(.bold))
                }.modifier(AuthButton())
            }.padding()
        }.onAppear()
    }
}

struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView(userId: 37).environmentObject( UserAuthenticationViewModel(id: 37, token: "14f2518e6ffc20cf52642b7c7d51b63b88fe127f", isLoggedIn: false))
    }
}
