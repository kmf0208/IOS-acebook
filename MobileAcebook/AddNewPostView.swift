//
//  AddNewPostView.swift
//  MobileAcebook
//
//  Created by Alina Ermakova on 12/10/2023.
//

import SwiftUI

struct CustomTextField: View {
    @State var message: String = ""
    @State var selectedItem: PhotosPickerItem? = nil
    @State var selectedImageData: Data = Data()
    var body: some View {
        HStack(alignment: .bottom) {
            HStack(spacing: 8) {
                withAnimation(.easeInOut) {
                    TextField("", text: $message, axis: .vertical)
                        .placeholder(when: message.isEmpty) {
                            Text("Message...")
                                .foregroundColor(.secondary)
                        }
                    // Add maximum vertical visible line limit
                        .lineLimit(...7)
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(.white)
            .cornerRadius(10)
            
            // Send button
                Button(action: {
                if selectedItem == nil {
                createNewPost()
                guard let token = UserDefaults.standard.string(forKey: "token") else {
                    return
                }
                service.getAllPosts(token: token) { (posts, err) in
                    guard let posts = posts else {
                        // handle error
                        return
                    }
                    self.posts = posts.posts
                }
            } else {
                createNewPost(image: selectedImageData)
                guard let token = UserDefaults.standard.string(forKey: "token") else {
                    return
                }
                service.getAllPosts(token: token) { (posts, err) in
                    guard let posts = posts else {
                        // handle error
                        return
                    }
                    self.posts = posts.posts
                }
            }
                } label: {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.largeTitle)
                })
                Button {
                    // make something
                } label: {
                       PhotosPicker(
                        selection: $selectedItem,
                        matching: .images,
                        photoLibrary: .shared()) {
                            Image(systemName: "photo.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(Color(.systemGray))
                            .onChange(of: selectedItem) { newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    selectedImageData = data
                                    print("image data \(selectedImageData)")
                                }
                        }
                    
                    }


                    // Image(systemName: "photo.circle.fill")
                    //     .font(.largeTitle)
                    //     .foregroundColor(Color(.systemGray))
                }
            }
        }
        .padding(.leading , 14)
        .padding(.trailing, 10)
        .padding(.vertical, 7)
        .frame(maxWidth: .infinity)
        .frame(minHeight: 55)
        .background(.ultraThinMaterial)
        .ignoresSafeArea()
        .animation(.easeInOut(duration: 0.3), value: message)
    }
    func createNewPost(image: Data = Data()) {
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            return
        }
        let post = CreatePost(image: image, message: postTextField)
        post.newPost(token: token)
    }
}
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}
struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField()
    }
}
