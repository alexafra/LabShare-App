//
//  PostListView.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 28/8/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct PostListView: View {
    @ObservedObject private var postListVM = PostListViewModel()

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Create new post")) {
                    HStack {
                        VStack {
                            TextField("Title: Enter up to 20 characters", text: self.$postListVM.newPostTitle)
                            TextField("Content: enter up to 1000 characters", text: self.$postListVM.newPostContent)
                        }
                        Button(action: {
                            self.postListVM.createPost()
                        }){
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                                .imageScale(.large)
                        }
                    }
                    
                }
                Section(header: Text("Posts:")) {
                    ForEach(self.postListVM.posts, id: \.id) {
                        postVM in
                       // NavigationLink(destination: PostDetail(post: post)) {
                        PostRowView(post: postVM.post)
                       // }
                    }.onDelete(perform: self.postListVM.deletePost)
                }
            }//.onAppear(perform: loadData)
                .navigationBarTitle("My Posts")
            
        }
    }
}

struct myPostViwq_Previews: PreviewProvider {
    
    static var previews: some View {
        PostListView()
    }
}

