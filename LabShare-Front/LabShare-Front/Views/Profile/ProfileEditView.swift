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

    
    init(userId: Int) {
        self.profileVM = ProfileViewModel(userId: userId)
    }
    
    var body: some View {
        VStack {
            ScrollView {
            
//                VStack(alignment: .center) {
                    
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
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("dob:")
                        DatePicker("", selection: self.$profileVM.profile.dob, in: Date()..., displayedComponents: .date)
                            .labelsHidden()
                        Spacer()
                    }
                    
//                        .modifier(TextFieldAuthorization())
                    
                    
                    
                        //.border(Color.green, width: 3)
                }.frame(minHeight: 0, maxHeight: .infinity)
                
                Button(action: {
                    self.profileVM.updateProfile(userAuthVM: userAuthVM)
                }) {
                    Text("Save")
                        .foregroundColor(Color.white)
                        .font(Font.title.weight(.bold))
                }.modifier(AuthButton())
                    
            }.padding()
            .frame(minHeight: 0, maxHeight: .infinity)
        }.onAppear(perform: self.profileVM.getProfileClosure(userAuthVM: userAuthVM))
    }
}

struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView(userId: 37).environmentObject( UserAuthenticationViewModel(id: 37, token: "14f2518e6ffc20cf52642b7c7d51b63b88fe127f", isLoggedIn: false))
    }
}
