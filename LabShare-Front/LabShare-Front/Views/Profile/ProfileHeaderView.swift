//
//  ProfileHeaderView.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 20/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct ProfileHeaderView: View {
    @ObservedObject var profileVM: ProfileViewModel
    var body: some View {
        VStack(alignment: .leading) {
            CircleImage()
                .padding(.leading, 30)
                .padding(.trailing, 30)
//            Text("Alex")
            HStack (alignment: .center) {
                Text("\(self.profileVM.profile.owner.firstName) \(self.profileVM.profile.owner.lastName)")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding()
                Button(action: {
                    
                }) {
                    Image(systemName: "line.horizontal.3").font(Font.largeTitle)
                }
                    
//                Spacer()
                
//                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
//                    Image(systemName: "line.horizontal.3")
//                })
//                Image(systemName: "line.horizontal.3")
//                    .contextMenu(ContextMenu(menuItems: {
//                        Text("Menu Item 1")
//                        Text("Menu Item 2")
//                        Text("Menu Item 3")
//                    })/*@END_MENU_TOKEN@*/)
                    //.font(.system(size: 16, weight: .regular))
//                contextMenu(menuItems: /*@START_MENU_TOKEN@*/{
//                    Text("Menu Item 1")
//                    Text("Menu Item 2")
//                    Text("Menu Item 3")
//                }/*@END_MENU_TOKEN@*/)
////
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
            Spacer()
        }.padding()
        .onAppear(perform: self.profileVM.getProfile)
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(profileVM: ProfileViewModel(userId: 10, profile: ProfileModel(id: 5, bio: "I like to dance and sing and be happy", dob: "2/4/1998", occupation: "Undergraduate", employer: "University of Western Australia", owner: UserModel(id: 10, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
    }
}
