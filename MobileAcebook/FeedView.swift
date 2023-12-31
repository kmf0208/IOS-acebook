//
//  SwiftUIView.swift
//  MobileAcebook
//
//  Created by Alina Ermakova on 09/10/2023.
//

import PhotosUI
import SwiftUI
import Cloudinary

struct FeedView: View {
    init(posts:[Post] = []) {
        self._posts = State(initialValue: posts)
    }
    @State var postTextField: String = ""
    @State var postArray: [String] = []
    private var service = FeedService()
    @State var posts = [Post]()
    //    @State var posts: [Post]
    
    var body: some View {
        VStack {
            HStack {
                Text("My Feed")
                    .padding(
                        EdgeInsets(
                            top: 34,
                            leading: 35,
                            bottom: 14,
                            trailing: 35
                        )
                    )
                    .font(Font.custom("Sulphur Point", size: 34))
                    .kerning(0.374)
                    .foregroundColor(.black)
                Spacer()
            }
            Spacer()
                .frame(height: 20)
            List(posts, id: \._id) { post in
                FeedPostView(post: post)
                    .listRowSeparator(.hidden)
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 20)
                            .background(.clear)
                            .foregroundColor(.white)
                            .padding(
                                EdgeInsets(
                                    top: 14,
                                    leading: 35,
                                    bottom: 14,
                                    trailing: 35
                                )
                            )
                    )
            }
            .listStyle(.plain)
            .onAppear {
                guard var token = UserDefaults.standard.string(forKey: "token") else {
                    return
                }
                service.getAllPosts(token: token) { (posts, err) in
                    guard var posts = posts else {
                        // handle error
                        return
                    }
                    self.posts = posts.posts
                }
            }
            .refreshable{
                guard var token = UserDefaults.standard.string(forKey: "token") else {
                    return
                }
                service.getAllPosts(token: token) { (posts, err) in
                    guard var posts = posts else {
                        // handle error
                        return
                    }
                    self.posts = posts.posts
                }
            }
            
            CustomTextField()
                .padding()
            Spacer()
                .frame(height: 20)
        }
        .frame(width: 400, height: 812)
        .background(
            LinearGradient(
                stops: [
                    Gradient.Stop(color: Color(red: 0.64, green: 0.66, blue: 0.65).opacity(0.13), location: 0.00),
                    Gradient.Stop(color: Color(red: 0.64, green: 0.66, blue: 0.65).opacity(0.55), location: 0.49),
                    Gradient.Stop(color: Color(red: 0.64, green: 0.66, blue: 0.65).opacity(0.17), location: 1.00),
                    Gradient.Stop(color: Color(red: 0.64, green: 0.66, blue: 0.65), location: 1.00),
                ],
                startPoint: UnitPoint(x: 0.77, y: 1),
                endPoint: UnitPoint(x: 0.76, y: 0)
            ))
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
