//
//  myProfileView.swift
//  LabShare-Front
//
//  Created by Ananda Buckley on 6/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct myProfileView: View {
    var body: some View {
        NavigationView {
            ProfileView(userId: 1)
        }
    }
}

struct myProfileView_Previews: PreviewProvider {
    static var previews: some View {
        myProfileView()
    }
}
