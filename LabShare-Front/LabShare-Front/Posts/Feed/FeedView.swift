//
//  FeedView.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 22/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI
import Combine

struct FeedView: View {
    
    @EnvironmentObject var userAuthVM: UserAuthenticationViewModel
    @ObservedObject var postListVM: PostListViewModel

    var body: some View {
        VStack {
            NavigationView {
                ScrollView{
                    PostListView(postListVM: self.postListVM)
                }.navigationBarTitle("", displayMode: .inline)
//                .navigationBarItems(trailing: SearchBarView2())
                .navigationBarItems(trailing:
                    NavigationLink(
                        destination: SearchBarView(userAuthVM: userAuthVM),
                        label: {
                            HStack {
                                Text("Search")
                                    .opacity(0.5).font(Font.system(.title))
                                Image(systemName: "magnifyingglass")
                                    .font(Font.system(.title).bold())
                            }
                        })
                    
                )
            }
            
        }.onAppear(perform: self.postListVM.getAllPostsClosure(userAuthVM: userAuthVM))
        
    }
}

struct FeedView_Previews: PreviewProvider {
    
    static var previews: some View {
//        NavigationView {
        FeedView(postListVM: PostListViewModel(userId: 80, postListType: PostListType.Feed))
            .environmentObject(UserAuthenticationViewModel(id: 80, token: "296251f6ec81048da3c9cc8a64192f54c4507072", isLoggedIn: true, isStaff: true, isActive: true))
//        }
    }
}
