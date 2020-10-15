//
//  ApprovalRowView.swift
//  LabShare-Front
//
//  Created by Ananda Buckley on 15/10/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct ApprovalRowView: View {
    @ObservedObject var userVM: UserViewModel
    @EnvironmentObject var userAuthVM: UserAuthenticationViewModel
    
    var body: some View {
        VStack {
            Divider()
            HStack {
                
                VStack (alignment: .leading, spacing: 5)  {
                    Text("\(userVM.user.firstName) \(userVM.user.lastName)").bold()
                        .font(Font.title)
                    
                    Text("\(userVM.user.email)")
                }
                
                Spacer()
                
                Button(action: {
                    userVM.user.isActive = true
                    userVM.updateIsActive(userAuthVM: userAuthVM)
                }, label: {
                    Text("Approve")
                        .foregroundColor(Color.white)
                        .font(Font.headline.weight(.bold))
                })
                .padding(.vertical, 15)
                .padding(.horizontal, 20)
                .background(Color.green)
                .cornerRadius(40)
                
            }
        }.padding()
    }
}

struct ApprovalRowView_Previews: PreviewProvider {
    static var previews: some View {
        ApprovalRowView(userVM: UserViewModel(user: UserModel(id: 1, email: "test@gmail", firstName: "Liam", lastName: "1", imageName: "image1", isStaff: false, isActive: true)))
    }
}
