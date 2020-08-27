//
//  ContentView.swift
//  LabShareFront
//
//  Created by Alexander Frazis on 27/8/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List {
            ForEach(0..<20) {
                index in
                PostRow(userName: "Alexander Frazis", postText: "I would like to give away 10 iphones", timeOfPost: "2020-07-22 16:48:31")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
