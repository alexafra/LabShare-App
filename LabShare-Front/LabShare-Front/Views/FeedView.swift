//
//  FeedView.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 22/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct FeedView: View {
    @EnvironmentObject var userAuthVM: UserAuthenticationViewModel
    @ObservedObject var postListVM: PostListViewModel
    //May want to think of alternative, does this need to be in a view?
    init(userId: Int) {
        self.postListVM = PostListViewModel(userId: userId)
    }
    
    var body: some View {
        VStack {
            NavigationView {
                ScrollView{
                    PostListView(postListVM: self.postListVM)
                }
            }
            .navigationBarTitle(Text(""), displayMode: .inline)
        }.onAppear(perform: self.postListVM.getFeedPosts)
        
        
        
    }
}


struct FeedView_Previews: PreviewProvider {
    static func supplyAuth (){
        PostWebService.setToken(token: "e3ef7d0655f1698e348a81eb184156b74612ad59")
        PostWebService.setLoggedInUserId(id: 1)
        ProfileWebService.setToken(token: "e3ef7d0655f1698e348a81eb184156b74612ad59")
        ProfileWebService.setLoggedInUserId(id: 1)
    }
    supplyAuth()
    
    static var previews: some View {
        
        FeedView(userId: 10)
            .environmentObject(UserAuthenticationViewModel(id: 1, token: "e3ef7d0655f1698e348a81eb184156b74612ad59", isLoggedIn: true))
            .onAppear(perform: supplyAuth)
        
//        NavigationView {
//        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
//            /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
//        })
//        VStack {
//            NavigationView {
//                Button(action: {
//
//                    self.isActive = true
//                }, label: {
//                    NavigationLink(
//                        destination: ,
//                        isActive: self.isActive,
//                        label: {
//                            /*@START_MENU_TOKEN@*/Text("Navigate")/*@END_MENU_TOKEN@*/
//                        })
//
//                })
//            }
//
//        }
       
            
//        }
        
    }
}
