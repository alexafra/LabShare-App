//
//  CommentHeaderView.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 4/10/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct CommentHeaderView: View {
    @ObservedObject var commentVM: CommentViewModel //Probs needs to change
    
    var body: some View {
        HStack() {
            Image(systemName: "person")
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
            VStack (alignment: .leading) {
                Text("\(self.commentVM.commentModel.author.firstName) \(self.commentVM.commentModel.author.lastName)")
                    .font(Font.subheadline)
                    .fontWeight(.bold)
                Text(self.commentVM.dateMessageString)
                    .font(Font.footnote).fontWeight(.thin)
            }
            Spacer()
        }
    }
}

struct CommentHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CommentHeaderView(commentVM: CommentViewModel())
    }
}
