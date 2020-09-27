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

    var body: some View {
        VStack {
            NavigationView {
                ScrollView{
                    PostListView(postListVM: self.postListVM)
                }.navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(trailing: SearchBarView())
            }
            
        }.onAppear(perform: self.postListVM.getAllPostsClosure(userAuthVM: userAuthVM))
        
    }
}

struct FeedView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        FeedView(postListVM: PostListViewModel(userId: 37, postListType: PostListType.Feed))
            .environmentObject(UserAuthenticationViewModel(id: 37, token: "14f2518e6ffc20cf52642b7c7d51b63b88fe127f", isLoggedIn: true))
        
    }
}
