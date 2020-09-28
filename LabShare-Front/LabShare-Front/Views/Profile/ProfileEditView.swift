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
                    
                VStack(alignment: .leading) {
                    Text("occupation:")
                    TextField("occupation", text: self.$profileVM.profile.occupation)
                        .modifier(TextFieldAuthorization())
                }.frame(minHeight: 0, maxHeight: .infinity)
                .padding(.top)
                
                VStack(alignment: .leading) {
                    Text("employer:")
                    TextField("employer", text: self.$profileVM.profile.employer).modifier(TextFieldAuthorization())
                }.frame(minHeight: 0, maxHeight: .infinity)
                .padding(.top)
        
                VStack(alignment: .leading) {
                    Text("bio:")
                    TextField("bio", text: self.$profileVM.profile.bio)
                        .modifier(TextFieldAuthorization())
                        .lineLimit(nil)
                }.frame(minHeight: 0, maxHeight: .infinity)
                .padding(.top)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("dob:")
                        DatePicker("", selection: self.$profileVM.profile.dob, in: Date()..., displayedComponents: .date)
                            .labelsHidden()
                        Spacer()
                    }
//                        .modifier(TextFieldAuthorization())
                        //.border(Color.green, width: 3)
                }
                .frame(minHeight: 0, maxHeight: .infinity)
                .padding(.top)
                
                Button(action: {
                    self.profileVM.updateProfile(userAuthVM: self.userAuthVM)
                }) {
                    Text("Save")
                        .foregroundColor(Color.white)
                        .font(Font.title.weight(.bold))
                }
                .modifier(AuthButton())
                .padding(.top)
                    
            }.padding()
            .frame(minHeight: 0, maxHeight: .infinity)
        }.onAppear(perform: self.profileVM.getProfileClosure(userAuthVM: userAuthVM))
    }
}

struct TextView: UIViewRepresentable {
    
    typealias UIViewType = UITextView
    var configuration = { (view: UIViewType) in }
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIViewType {
        UIViewType()
    }
    
    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<Self>) {
        configuration(uiView)
    }
}

struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView(userId: 37)
            .environmentObject( UserAuthenticationViewModel(id: 37, token: "14f2518e6ffc20cf52642b7c7d51b63b88fe127f", isLoggedIn: false))
    }
}
