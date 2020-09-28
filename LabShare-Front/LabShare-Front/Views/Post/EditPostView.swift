//
//  PostDetail.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 29/8/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct EditPostView: View {
    @ObservedObject var postVM: PostViewModel
    @ObservedObject var oldpostVM: PostViewModel
    @EnvironmentObject var userAuthVM: UserAuthenticationViewModel
    @Binding var isPresented: Bool
    @State var showingAlert = false
    
    //    @ViewBuilder
    var body: some View {
        VStack (alignment:.leading) {
            PostHeaderView(postVM: self.postVM)
            
            VStack {
                HStack {
                    Text("Title:")
                        .font(.title)
                        .foregroundColor(Color.black)
                        .fontWeight(.bold)
                    Spacer()
                }
                
                TextField("title", text: self.$postVM.post.title)
                    .font(.largeTitle)
                    .foregroundColor(Color.black)
            }
            

            VStack {
                HStack {
                    Text("Contents:")
                        .font(.title)
                        .foregroundColor(Color.black)
                        .fontWeight(.bold)
                    Spacer()
                }
                
                
                MultilineTextView(text: self.$postVM.post.content)
            }
            
            
            HStack {
                Button(action: {
                    self.showingAlert = true
                }){
                    Text("Cancel")
                }.alert(isPresented:$showingAlert) {
                    Alert(title: Text("Are you sure you want to cancel"), message: Text("All edits will be lost"), primaryButton: .destructive(Text("Continue")) {
                        self.isPresented = false
                    }, secondaryButton: .cancel())
                }
                
                Spacer()
                
                Button(action: {
                    self.oldpostVM.updatePost(userAuthVM: self.userAuthVM, newPost: self.postVM.post)
                    self.isPresented = false
                }){
                    Text("Save")
                }
            }
            
            Spacer()
        }.padding([.top, .leading, .trailing])
    }
}

struct MultilineTextView: UIViewRepresentable {
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
    
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.font = .systemFont(ofSize: 18)
        return view
    }
}

//struct EditPostView_Preview: PreviewProvider {
  //  static var previews: some View {
       // EditPostView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "Dave found joy in the daily routine of life. He awoke at the same time, ate the same breakfast and drove the same commute. He worked at a job that never seemed to change and he got home at 6 pm sharp every night. It was who he had been for the last ten years and he had no idea that was all about to change.", dateCreated: "2020-07-22 16:48:31", author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis")))).environmentObject(UserAuthenticationViewModel(id: 37, token: "14f2518e6ffc20cf52642b7c7d51b63b88fe127f", isLoggedIn: true), Binding.constant(True))
//}
//}
