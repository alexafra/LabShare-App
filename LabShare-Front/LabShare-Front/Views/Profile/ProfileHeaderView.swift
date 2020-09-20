//
//  ProfileHeaderView.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 20/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct ProfileHeaderView: View {
    @ObservedObject private var profileVM: ProfileViewModel
    init(userId: Int) {
        self.profileVM = ProfileViewModel(profileModel: ProfileModel(id: userId))
    }
    var body: some View {
        VStack {  
            CircleImage()
                .padding(.leading, 30)
                .padding(.trailing, 30)
            HStack {
                Spacer()
//                Text(self.profileVM.profile.name)
                Text("Alex Frazis")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.bottom)
                Spacer()
            }.padding(.top, 15)
                .padding(.bottom, -10)

            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("About")
                            .font(.title)
                            .fontWeight(.medium)
                        Text("Email: 22499153@student.uwa.edu.au\nMobile: 0450215119\nLocation: QEII\nJoined in: 2020").font(.footnote).padding(.horizontal,5)
                    }
                    Spacer()
                }
                HStack{
                    Text(self.profileVM.profile.name + "'s Posts")
                        .font(.title)
                        .fontWeight(.medium)
                    Spacer()
                }
            }.padding(.leading, 5)
            Spacer()
        }.onAppear(perform: self.profileVM.getUser)
        
        
        
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(userId: 3)
    }
}
