//
//  ContactDetails.swift
//  LabShare-Front
//
//  Created by Ananda Buckley on 30/8/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct ContactDetails: View {
    var user: User
    
    var body: some View {

            HStack {
                VStack(alignment: .leading) {
                    
                Text(self.user.name)
                    
                }.padding()
                Spacer()
            }.padding()
        
    }
}

struct ContactDetails_Previews: PreviewProvider {
    static var previews: some View {
        ContactDetails(user: User(id: 1, name: "Liam Niedzielski"))
    }
}
