
//
//  SearchBarView.swift
//  LabShare-Front
//
//  Created by Ananda Buckley on 5/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct SearchBarView: View {
    
    @State var searchResult = ""
    @State var show = false
    @State var searchID = -1
    
    var body: some View {

        HStack {
            VStack {
                TextField("Search", text: $searchResult)
                    .frame(width: 100.0)
            }
            
            VStack {
                NavigationLink(destination: ProfileView(userId: searchID), isActive: $show) {
                    Image(systemName: "")
                }
                
                Button(action: {
                    self.searchID = Int(self.searchResult) ?? -1
                    if self.searchID == -1 {
                        self.show = false
                    }
                    else {
                        self.show = true
                    }
                }) {
                    Image(systemName: "magnifyingglass")
                }.offset(x: 0, y: -6)
            }
            }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
    }
}
