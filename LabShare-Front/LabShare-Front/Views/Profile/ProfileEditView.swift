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
    @Binding var showSelf: Bool

//    @Binding var showSelf: Bool

    
    init(userId: Int, showSelf: Binding<Bool>) {
        self.profileVM = ProfileViewModel(userId: userId)
        self._showSelf = showSelf
    }
    
    init(userId: Int) {
        self.init(userId: userId, showSelf: .constant(true))
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("occupation:")
                    TextField("", text: self.$profileVM.profile.occupation)
                        .modifier(TextFieldAuthorization())
                    
                }
                .padding()
                
                VStack(alignment: .leading) {
                    Text("employer:")
                    TextField("", text: self.$profileVM.profile.employer).modifier(TextFieldAuthorization())
                }
                .padding()
        
                VStack(alignment: .leading) {
                    Text("bio:")
                    ZStack {
                        MultilineTextView(text: self.$profileVM.profile.bio)
                        Text(self.profileVM.profile.bio).opacity(0).padding(.top, 12).modifier(MultiLineTextFieldAuthorization())
                    }
                }
                .padding()
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("dob:")
                        DatePicker("", selection: self.$profileVM.profile.dob, in: ...Date(), displayedComponents: .date)
                            .labelsHidden()
                        Spacer()
                    }
                }
                .padding()
                
                Button(action: {
                    self.profileVM.updateProfile(userAuthVM: self.userAuthVM)
                    self.showSelf = false
                }) {
                    Text("Save")
                        .foregroundColor(Color.white)
                        .font(Font.title.weight(.bold))
                }
                .modifier(AuthButton())
                .padding(.top)
                    
            }
            
            
        }.padding()
//        .frame(minHeight: 0, maxHeight: .infinity)
        .KeyboardAwarePadding()
        .onAppear(
            perform:
                self.profileVM.getProfileClosure(userAuthVM: userAuthVM)
            
        )
        
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
        ProfileEditView(userId: 76, showSelf: .constant(true))
            .environmentObject( UserAuthenticationViewModel(id: 76, token: "e6d3868c84c0cb418cb676d3fca4d9a9d03c90d8", isLoggedIn: false))
    }
}
