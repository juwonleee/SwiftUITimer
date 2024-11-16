//
//  ContentView.swift
//  SwiftUITimer
//
//  Created by Lee Juwon on 11/16/24.
//

import SwiftUI

struct ContentView: View {
  @State private var timeRemaining = 60
  @State private var timerActive = false
  @State private var cancellable: Cancellable? = nil

    var body: some View {

        VStack {
          ZStack {
            Circle()
              .fill(Color("TimerBg"))
              .frame(width: 273, height: 273)

            Circle()
              .stroke(Color("MainColor"), lineWidth: 18)
              .padding(9)
              .frame(width: 240, height: 240)

            VStack {
              Text("GCU • KHU")

              Text("GDG on Campus")

              Text("00:\(timeRemaining)")
                .font(.largeTitle)
                .bold()
            }

          }

          HStack(spacing:12) {
            Button(action: startTimer) {
              ZStack {
                Rectangle()
                  .fill(Color("MainColor"))
                  .frame(width: 131, height: 43)
                  .cornerRadius(12)
                Text("Start")
              }
            }


            Button(action: resetTimer) {
              ZStack {
                Rectangle()
                  .fill(Color("MainColor"))
                  .frame(width: 131, height: 43)
                  .cornerRadius(12)
                Text("Reset")
              }
            }



          }
        }
        .padding()
      }



}

#Preview {
    ContentView()
}
