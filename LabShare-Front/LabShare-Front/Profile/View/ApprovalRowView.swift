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
        
        VStack (alignment: .leading, spacing: 5)  {
            Divider()
            Text("\(userVM.user.firstName) \(userVM.user.lastName)").bold()
                .font(Font.title)
            
            Text("\(userVM.user.email)")
            
            HStack{
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
                
                Button(action: {
                    // Delete user
                }, label: {
                    Text("   Deny   ")
                        .foregroundColor(Color.black)
                        .font(Font.headline.weight(.bold))
                })
                .padding(.vertical, 15)
                .padding(.horizontal, 20)
                .background(Color.white)
                .overlay(RoundedRectangle(cornerRadius: 40)
                                .stroke(Color.black, lineWidth: 4))            }
        }.padding()
    }
}
        
        struct ApprovalRowView_Previews: PreviewProvider {
            static var previews: some View {
                ApprovalRowView(userVM: UserViewModel(user: UserModel(id: 1, email: "22499153@gmail", firstName: "Liam", lastName: "Niedzielski", imageName: "image1", isStaff: false, isActive: true)))
            }
        }
