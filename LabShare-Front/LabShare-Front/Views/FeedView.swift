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
                PostListView(postListVM: self.postListVM)
            }.onAppear(perform: self.postListVM.getFeedPosts)
        }
        
    }
}


struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(userId: 10).environmentObject(UserAuthenticationViewModel(id: 10, token: "a47f3319dd15cc56dcb451dbeffa8dade3ea5587", isLoggedIn: true))
    }
}
