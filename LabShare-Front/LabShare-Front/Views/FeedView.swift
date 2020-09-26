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

    init (userAuthVM: UserAuthenticationViewModel) {
        postListVM = PostListViewModel(userAuthVM: userAuthVM)
    }
    
    var body: some View {
        VStack {
            NavigationView {
                ScrollView{
                    PostListView(postListVM: self.postListVM)
                }.navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(trailing: SearchBarView())
            }
            
        }.onAppear(perform: self.postListVM.getFeedPosts)
        
    }
}

struct FeedView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        FeedView(userAuthVM: UserAuthenticationViewModel(id: 1, token: "e3ef7d0655f1698e348a81eb184156b74612ad59", isLoggedIn: true))
            .environmentObject(UserAuthenticationViewModel(id: 1, token: "e3ef7d0655f1698e348a81eb184156b74612ad59", isLoggedIn: true))
        
    }
}
