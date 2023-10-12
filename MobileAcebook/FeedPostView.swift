//
//  FeedPostView.swift
//  MobileAcebook
//
//  Created by Alina Ermakova on 12/10/2023.
//

import SwiftUI

struct FeedPostView: View {
    let post: Post
    
    var body: some View {
        let dateString = post.createdAt
        let components = dateString.components(separatedBy: "T")
        let datePart = components.first ?? ""
        
        VStack(alignment: .leading) {
            HStack{
                Image("A")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(10)
                    .background(Color.clear)
                    .clipShape(Circle())
                VStack(alignment: .leading){
                    Text("Username")
                    Text("\(datePart)")
                        .font(Font.custom("Sulphur Point", size: 15))
                        .foregroundColor(.gray)
                }
                
            }
            Spacer()
                .frame(height: 24)
            Text(post.message)
                .foregroundColor(.black)
                .font(Font.custom("Sulphur Point", size: 20))
            Spacer()
                .frame(height: 24)
            VStack {
                HStack {
                    Spacer()
                    Text("\(post.comments)")
                        .font(Font.custom("Sulphur Point", size: 20))
                    Image("bubble")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("\(post.likes.count)")
                        .font(Font.custom("Sulphur Point", size: 20))
                    Image("heart")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            }
        }
        .padding(
            EdgeInsets(
                top: 25,
                leading: 45,
                bottom: 25,
                trailing: 40
            )
        )
    }
}

struct FeedPostView_Previews: PreviewProvider {
    static var previews: some View {
        FeedPostView(post: Post(_id: "6526d1736d503c29b66c26a6", comments: 0, createdAt: "2023-10-11T16:46:43.531Z", createdBy: "65268f24de740a69110637ab", image: "", likes: [], message: "Post 3"))
    }
}
