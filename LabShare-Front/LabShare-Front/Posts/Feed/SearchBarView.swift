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
    @ObservedObject var searchVM: SearchViewModel = SearchViewModel()
    @State var queryString: String = ""
    
    init (userAuthVM: UserAuthenticationViewModel) {
//        searchVM = SearchViewModel(userAuthVM: userAuthVM)
    }
    var body: some View {
//        let binding = Binding<String>(get: {
//            self.queryString
//        }, set: {
//            self.queryString = $0
//            self.searchVM.getUsersSearch(userAuthVM: userAuthVM, queryString: self.queryString)
//        })
        ScrollView {
            VStack(alignment: .leading) {
                
                HStack {
                    TextField("Search LabShare", text: $queryString)
                        
                        .onChange(of: queryString) {
                            self.searchVM.getUsersSearch(userAuthVM: userAuthVM, queryString: $0)
                                
                        }
                        .modifier(TextFieldAuthorization())
                        .font(Font.system(.title))
                }
                Text("Users:").font(Font.title)
                Divider()
                ForEach(self.searchVM.users, id: \.id) {
                    user in
                    NavigationLink(
                        destination: ProfileView(userId: user.id),
                        label: {
                            HStack {
                                Text("\(user.firstName) \(user.lastName)").bold()
                                    .font(Font.title)
                            }
                            
                            
                        }
                    ).buttonStyle(PlainButtonStyle())
                    Divider()
                }
                Spacer()
                
                
                
            }.padding()
        }.onAppear(perform: {
            self.searchVM.getUsersSearch(userAuthVM: userAuthVM, queryString: queryString)
        })
//        .navigationBarTitle("")
//        .navigationBarHidden(true)
        
        
//        .navigationBarItems(trailing:
//
//        )
        
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchBarView(userAuthVM: UserAuthenticationViewModel(id: 1, token: "d620ebc3ca80b02814afd8be67f6c815cca2296c", isLoggedIn: true, isStaff: true, isActive: true))
        }.environmentObject(UserAuthenticationViewModel(id: 1, token: "d620ebc3ca80b02814afd8be67f6c815cca2296c", isLoggedIn: true, isStaff: true, isActive: true))
        
    }
}
