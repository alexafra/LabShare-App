//
//  ProfileHeaderView.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 20/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI
import Combine

struct ProfileHeaderView: View {
    @EnvironmentObject var userAuthVM: UserAuthenticationViewModel
    @ObservedObject var profileVM: ProfileViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            CircleImageUpdatable(imageName: self.$profileVM.profile.owner.imageName)
                .padding(.leading, 30)
                .padding(.trailing, 30)
            
            HStack {
                Spacer()
                Text("\(self.profileVM.profile.owner.firstName) \(self.profileVM.profile.owner.lastName)")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding()
                Spacer()
            }
                

            VStack (alignment: .leading, spacing: 7) {
                Text("About")
                    .font(.title)
                    .fontWeight(.medium)
                
                Text("Email: \(self.profileVM.profile.owner.email)")
                    .fixedSize(horizontal: false, vertical: true)
//                Text("Born: \(self.profileVM.profile.dob)")
//                if profileVM.dobExists {
//                    Text("Born: " + self.profileVM.dobString)
//                        .fixedSize(horizontal: false, vertical: true)
//                }
                if profileVM.occupationExists {
                    Text("Occupation: \(self.profileVM.profile.occupation)")
                        .fixedSize(horizontal: false, vertical: true)
                }
                if profileVM.employerExists {
                    Text("Employer: \(self.profileVM.profile.employer)")
                        .fixedSize(horizontal: false, vertical: true)
                }
                if profileVM.bioExists {
                    Text("Bio: \(self.profileVM.profile.bio)")
                        .fixedSize(horizontal: false, vertical: true)
                }
                
            }
        }.padding()
        
        .navigationBarItems(trailing: Group {
            if (profileVM.profile.owner.id == userAuthVM.userAuth.id || userAuthVM.userAuth.isStaff) {
                NavigationLink (
                    destination: ProfileSettingsView(profileVM: self.profileVM),
                    label: {
                        Image(systemName: "line.horizontal.3").font(Font.largeTitle)
                    }
                )
            }
        })
        .onAppear(perform: self.profileVM.getProfileClosure(userAuthVM: userAuthVM))
    
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProfileHeaderView(profileVM: ProfileViewModel(userId: 72))
                .environmentObject(UserAuthenticationViewModel(id: 72, token: "d4e3814547b0b328f3baae5ea78a3b1417464386", isLoggedIn: true, isStaff: true, isActive: true))
            
            ProfileHeaderView(profileVM: ProfileViewModel(userId: 70))
                .environmentObject(UserAuthenticationViewModel(id: 70, token: "356a0facdfb32b8720ada293893c4dae6267d406", isLoggedIn: true, isStaff: true, isActive: true))
            
//            ProfileHeaderView(profileVM: ProfileViewModel(profile: ProfileModel(id: 37, bio: "I like programming and to study and to dance and to sing and to play baseball and to play soccer and to play jazz", dob: Date(), occupation: "Student", employer: "University of Western Australia", owner: UserModel(id: 37, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
//                .environmentObject(UserAuthenticationViewModel(id: 37, token: "14f2518e6ffc20cf52642b7c7d51b63b88fe127f", isLoggedIn: true))
        }
        
            
    }
}
