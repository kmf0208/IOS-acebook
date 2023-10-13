//
//  SignUpView.swift
//  MobileAcebook
//
//  Created by Alina Ermakova on 09/10/2023.
//

import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var token: String? = nil
    @State private var isSecured: Bool = true
    private var service = AuthenticationService()
    @State private var loginStatus: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15.0) {
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
                    .foregroundColor(.black)
            }
            Spacer()
                .frame(height: 50)
            Text("Welcome back! Glad to see you, Again!")
                .font(Font.custom("Sulphur Point", size: 28))
                .foregroundColor(Color(red: 0.12, green: 0.14, blue: 0.17))
                .frame(width: 280, alignment: .topLeading)
            Spacer()
            VStack {
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .autocorrectionDisabled(true)
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
                
                SecureField("Password", text: $password)
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
                
                Text(loginStatus)
                    .foregroundColor(Color(red: 0.83, green: 0.2, blue: 0.2))
                    .padding(.top, 8)
                    .font(Font.custom("Sulphur Point", size: 20))
                ZStack{
                    Button("Sign in") {
                        service.signIn(email: email, password: password) { (receivedToken, err) in
                            if let token = receivedToken {
                                self.token = token
                                UserDefaults.standard.set(token, forKey: "token")
                                loginStatus = "Login successful"
                            } else {
                                if let error = err {
                                    loginStatus = error.localizedDescription
                                } else {
                                    loginStatus = "Invalid email or password"
                                }
                            }
                        }
                    }
                    .padding(.leading, 28)
                    .foregroundColor(.black)
                    .font(Font.custom("Sulphur Point", size: 20))
                    .disabled(token != nil)
                    .opacity(token == nil ? 1.0 : 0.5)
                    NavigationLink("",
                                   destination: FeedView(),
                                   isActive: Binding<Bool>(
                                    get: { self.token != nil },
                                    set: { _ in }
                                   )
                    )
                    .opacity(token != nil ? 1.0 : 0.0)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .frame(width: 151, height: 49, alignment: .leading)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .inset(by: 0.5)
                        .stroke(Color(red: 0.16, green: 0.16, blue: 0.16), lineWidth: 1))
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
struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
