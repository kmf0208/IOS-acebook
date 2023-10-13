//
//  signupPageView.swift
//  MobileAcebook
//
//  Created by Alice Birkett on 09/10/2023.
//

import SwiftUI

struct SignupPageView: View {
    
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var isEmailValid = false
    @State private var password: String = ""
    @State private var password2: String = ""
    @State private var avatar: String? = nil
    @State private var isRegistrationComplete = false
    
    func submitUser() -> Void {
        let signupService = SignupService(email: email, username: username, password: password, password2: password2, avatar: avatar)
        signupService.createAccount()
        isRegistrationComplete = true
    }
    
    func isValidEmail(_ email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15.0){
            Spacer()
                .frame(height: 50)
            HStack(alignment: .bottom) {
                Image("A")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 53, height: 73)
                    .accessibilityIdentifier("acebok-logo")
                Text("Acebook")
                    .font(Font.custom("Sulphur Point", size: 32))
                    .kerning(0.64661)
                    .foregroundColor(.black)
            }
            Spacer()
                .frame(height: 50)
            Text("Welcome!")
                .font(Font.custom("Sulphur Point", size: 28))
                .foregroundColor(Color(red: 0.12, green: 0.14, blue: 0.17))
                .frame(width: 280, alignment: .topLeading)
            Spacer()
            VStack {
                TextField("Username", text: $username)
                    .padding()
                    .background(.white)
                    .foregroundColor(.black)
                    .frame(width: 330, height: 56)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .inset(by: 0.5)
                            .stroke(.white, lineWidth: 1))
                    .font(Font.custom("Sulphur Point", size: 22))
                
                TextField("Email address", text: $email, onEditingChanged: { editing in
                            if !editing {
                                isEmailValid = isValidEmail(email)
                            })
                    .padding()
                    .background(.white)
                    .foregroundColor(.black)
                    .frame(width: 330, height: 56)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .inset(by: 0.5)
                            .stroke(.white, lineWidth: 1))
                    .font(Font.custom("Sulphur Point", size: 22))
                
                SecureInputView("Password", text: $password)
                    .padding()
                    .background(.white)
                    .foregroundColor(.black)
                    .frame(width: 330, height: 56)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .inset(by: 0.5)
                            .stroke(.white, lineWidth: 1))
                    .font(Font.custom("Sulphur Point", size: 22))
                
                SecureInputView("Confirm password", text: $password2)
                    .padding()
                    .background(.white)
                    .foregroundColor(.black)
                    .frame(width: 330, height: 56)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .inset(by: 0.5)
                            .stroke(.white, lineWidth: 1))
                    .font(Font.custom("Sulphur Point", size: 22))
                
              
                if !isEmailValid {
                    Text("Invalid email address").foregroundStyle(.red)
                } else if password != password2 {
                    Text("Passwords must match!").foregroundStyle(Color(red: 0.83, green: 0.2, blue: 0.2))
                } else if password.count < 8 {
                    Text("Passwords must have a length of 8 or more").foregroundStyle(Color(red: 0.83, green: 0.2, blue: 0.2))
                } else if password.lowercased() == password {
                    Text("Passwords must hava a capital letter").foregroundStyle(Color(red: 0.83, green: 0.2, blue: 0.2))
                } else {
                    NavigationLink(destination: SignInView()) {
                        Text("Submit")
                            .padding(.leading, 45)
                            .frame(width: 151, height: 49, alignment: .leading)
                            .cornerRadius(8)
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .inset(by: 0.5)
                                    .stroke(Color(red: 0.16, green: 0.16, blue: 0.16), lineWidth: 1))
                        
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        submitUser()
                    })
                }
            }
            .padding(.top, -150.0)
            Spacer()
        }
        .padding(.top, 5.0)
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
                endPoint: UnitPoint(x: 0.76, y: 0)))
        Spacer()
    }
}

struct SignupPageView_Previews: PreviewProvider {
    static var previews: some View {
        SignupPageView()
    }
}

struct SecureInputView: View {
    
    @Binding private var text: String
    @State private var isSecured: Bool = true
    private var title: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    SecureField(title, text: $text)
                } else {
                    TextField(title, text: $text)
                }
            }.padding(.trailing, 32)
            
            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .accentColor(.gray)
            }
        }
    }
}
