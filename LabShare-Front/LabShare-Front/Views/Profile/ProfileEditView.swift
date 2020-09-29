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
                    TextField("", text: self.$profileVM.profile.occupation)
                        .modifier(TextFieldAuthorization())
                    
                }
                .padding(.top)
                
                VStack(alignment: .leading) {
                    Text("employer:")
                    TextField("", text: self.$profileVM.profile.employer).modifier(TextFieldAuthorization())
                }
                .padding(.top)
        
                VStack(alignment: .leading) {
                    Text("bio:")
                    ZStack {
                        MultilineTextView(text: self.$profileVM.profile.bio)
                        Text(self.profileVM.profile.bio).opacity(0).padding(.top, 12).modifier(MultiLineTextFieldAuthorization())
                    }
                }
                .padding(.top)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("dob:")
//                        DatePicker(
//                            "",
//                            selection: Binding<Date>(get: {self.profileVM.profile.dob ?? Date()}, set: {self.profileVM.profile.dob = $0}),
//                            displayedComponents: .date
//                        )
//                        DatePicker("", selection: self.$profileVM.profile.dob ?? Date(), in: ...Date(), displayedComponents: .date)
                        DatePicker("", selection: self.$profileVM.profile.dob, in: ...Date(), displayedComponents: .date)
                            .labelsHidden()
                        Spacer()
                    }
                }
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
            
            
        }.frame(minHeight: 0, maxHeight: .infinity)
        .onAppear(perform: self.profileVM.getProfileClosure(userAuthVM: userAuthVM))
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
        ProfileEditView(userId: 67)
            .environmentObject( UserAuthenticationViewModel(id: 67, token: "ff93cb88141ba6e09b69ca3d7c5a395a64295626", isLoggedIn: false))
    }
}
