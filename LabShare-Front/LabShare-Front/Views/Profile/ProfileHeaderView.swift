//
//  ProfileHeaderView.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 20/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct ProfileHeaderView: View {
    @EnvironmentObject var userAuthVM: UserAuthenticationViewModel
    @ObservedObject var profileVM: ProfileViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            CircleImage()
                .padding(.leading, 30)
                .padding(.trailing, 30)
            HStack (alignment: .center) {
                Text("\(self.profileVM.profile.owner.firstName) \(self.profileVM.profile.owner.lastName)")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding()
                Button(action: {
                    
                }) {
                    Image(systemName: "line.horizontal.3").font(Font.largeTitle)
                }
            }
            

            VStack (alignment: .leading, spacing: 7) {
                Text("About")
                    .font(.title)
                    .fontWeight(.medium)
                
                Text("Email: \(self.profileVM.profile.owner.email)")
                Text("Born: \(self.profileVM.profile.dob)")
                Text("Occupation: \(self.profileVM.profile.occupation)")
                Text("Employer: \(self.profileVM.profile.employer)")
                Text("Bio: \(self.profileVM.profile.bio)")
            }.padding(.leading, 5)
        }.padding()
        .onAppear(perform: self.profileVM.getProfileClosure(userAuthVM: userAuthVM))
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(profileVM: ProfileViewModel(profile: ProfileModel(id: 37, bio: "I like programming and to study and to dance and to sing and to play baseball and to play soccer and to play jazz", dob: "1998-05-02", occupation: "Student", employer: "University of Western Australia", owner: UserModel(id: 37, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
            .environmentObject(UserAuthenticationViewModel(id: 37, token: "14f2518e6ffc20cf52642b7c7d51b63b88fe127f", isLoggedIn: true))
    }
}
