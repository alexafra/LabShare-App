//
//  KitToSwiftUIHelper.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 28/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct KitToSwiftUIHelper: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct MultilineTextView: UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.textAlignment = .left
        view.font = UIFont(name: "Times New Roman", size: 20)
        view.delegate = context.coordinator
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.autoresizingMask = [.width, .height]
        return view
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> MultilineTextView.Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var control: MultilineTextView

        init(_ control: MultilineTextView) {
            self.control = control
        }

        func textViewDidChange(_ textView: UITextView) {
            control.text = textView.text
        }
    }
}

//struct MultilineTextView2: UIViewRepresentable {
//    @Binding var text: String
//
//    func makeUIView(context: Context) -> UITextView {
////        let view = UITextView()
////        view.isScrollEnabled = true
////        view.isEditable = true
////        view.isUserInteractionEnabled = true
//        let view = UITextView()
//        view.translatesAutoresizingMaskIntoConstraints = true
//        view.sizeToFit()
//        view.isScrollEnabled = false
//        view.sizeToFit()
//        view.isEditable = true
//        view.isUserInteractionEnabled = true
//        view.textAlignment = .left
//        view.font = UIFont(name: "Times New Roman", size: 20)
//        
////        var frame = view.frame
////        frame.size.height = view.contentSize.height
////        view.frame = frame
//        return view
//    }
//
//    func updateUIView(_ uiView: UITextView, context: Context) {
//        uiView.text = text
//    }
//}

struct KitToSwiftUIHelper_Previews: PreviewProvider {
    static var previews: some View {
        KitToSwiftUIHelper()
    }
}
