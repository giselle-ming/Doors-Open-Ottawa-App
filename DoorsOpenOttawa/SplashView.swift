//
//  SplashView.swift
//  DoorsOpenOttawa
//
//  Created by Giselle Mingue Rios on 2023-11-23.
//

import SwiftUI

struct SplashView: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack {
            if self.isActive {
                ContentView()
            } else {
                Image("splashScreen")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
    
}

#Preview {
    SplashView()
}
