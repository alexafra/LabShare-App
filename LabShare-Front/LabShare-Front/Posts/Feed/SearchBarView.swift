//
//  SearchBarView.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 4/10/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI
import Combine

struct SearchBarView: View {
    @EnvironmentObject var userAuthVM: UserAuthenticationViewModel
    @StateObject var searchVM: SearchViewModel = SearchViewModel()
    init (userAuthVM: UserAuthenticationViewModel) {
//        searchVM = SearchViewModel(userAuthVM: userAuthVM)
    }
    var body: some View {
        VStack {
            Text("Users:")
            ForEach(self.searchVM.users, id: \.id) {
                user in
                NavigationLink(
                    destination: ProfileView(userId: user.id),
                    label: {
                        Text("\(user.firstName) \(user.lastName)")
                        
                    }
                )
                Divider()
            }
        }
        .navigationBarItems(trailing:
            HStack {
                TextField("Search LabShare", text: self.$searchVM.userQuery, onEditingChanged: { (changed) in
                    if changed {
                        self.searchVM.getUsersSearch(userAuthVM: userAuthVM)
                    } else {
                        //self.searchVM.getUsersSearch(userAuthVM: userAuthVM)
                    }
                    
                })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(Font.system(.title))
                Spacer()
            }
        )
        
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchBarView(userAuthVM: UserAuthenticationViewModel(id: 80, token: "296251f6ec81048da3c9cc8a64192f54c4507072", isLoggedIn: true))
        }.environmentObject(UserAuthenticationViewModel(id: 80, token: "296251f6ec81048da3c9cc8a64192f54c4507072", isLoggedIn: true))
        
    }
}
