//
//  WelcomePageView.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 30/09/2023.
//

import SwiftUI


struct WelcomePageView: View {
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Image("A")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .accessibilityIdentifier("acebook-logo")
                
                Text("ACEBOOK").font(.custom("SulphurPoint-Regular", size: 48))
                    .font(.largeTitle)
                    .padding(.bottom, 20)
                    .accessibilityIdentifier("welcomeText")
                
                Spacer()
                
                HStack{
                    Button(action: {
                        print("Floating Button Click")
                    }, label: {
                        NavigationLink(destination: SignInView()) {
                            Text("Sign In")
                                .padding(.leading, 28)
                                .font(Font.custom("Sulphur Point", size: 18))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                                .frame(width: 123, height: 13, alignment: .top)
                        }
                    })
                    .frame(width: 151, height: 49, alignment: .leading)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .inset(by: 0.5)
                            .stroke(Color(red: 0.16, green: 0.16, blue: 0.16), lineWidth: 1)
                    )
                    
                    Button(action: {
                        print("Floating Button Click")
                    }, label: {
                        NavigationLink(destination:             SignupPageView()) {
                            Text("Sign Up")
                                .padding(.leading, 28)
                                .foregroundColor(.black)
                                .font(Font.custom("Sulphur Point", size: 18))
                                .frame(width: 123, height: 13, alignment: .top)
                                .multilineTextAlignment(.center)
                        }
                    })
                    .frame(width: 151, height: 49, alignment: .leading)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .inset(by: 0.5)
                            .stroke(Color(red: 0.16, green: 0.16, blue: 0.16), lineWidth: 1)
                    )
                }
                Spacer()
            }
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
                endPoint: UnitPoint(x: 0.76, y: 0)))
    }
}

struct WelcomePageView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePageView()
    }
}
