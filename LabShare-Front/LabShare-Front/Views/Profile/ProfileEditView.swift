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
    @ObservedObject var profileVM: ProfileViewModel
    var body: some View {
        VStack {
            if (profileVM.hasCompletedLoading) {
                ProfileView(userId: userAuthVM.userAuth.id)
            } else {
                VStack(alignment: .center, spacing: 40) {
                    Text("\(profileVM.profile.owner.firstName) \(profileVM.profile.owner.lastName)")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    VStack(alignment: .leading) {
                        Text("dob:")
                        TextField("dob", text: self.$profileVM.profile.dob)
                            .modifier(TextFieldAuthorization())
                    }
                
                    VStack(alignment: .leading) {
                        Text("occupation:")
                        TextField("occupation", text: self.$profileVM.profile.occupation)
                            .modifier(TextFieldAuthorization())
                    }
                    VStack(alignment: .leading) {
                        Text("employer:")
                        TextField("employer", text: self.$profileVM.profile.employer).modifier(TextFieldAuthorization())
                    }
            
                    VStack(alignment: .leading) {
                        Text("bio:")
                        TextField("bio", text: self.$profileVM.profile.bio)
                            .modifier(TextFieldAuthorization())
                    }
                    Button(action: {
                    }) {
                        Text("Save")
                            .foregroundColor(Color.white)
                            .font(Font.title.weight(.bold))
                    }.modifier(AuthButton())
                    Spacer()
                }.padding()
            }
        }
    }
}

struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView(profileVM: ProfileViewModel(userId: 10, profile: ProfileModel(id: 5, bio: "I like to dance and sing and be happy", dob: "2/4/1998", occupation: "Undergraduate", employer: "University of Western Australia", owner: UserModel(id: 10, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis")))).environmentObject(UserAuthenticationViewModel(id: 10, token: "a47f3319dd15cc56dcb451dbeffa8dade3ea5587", isLoggedIn: true))
    }
}
