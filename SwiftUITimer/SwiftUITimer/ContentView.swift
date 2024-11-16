//
//  ContentView.swift
//  SwiftUITimer
//
//  Created by Lee Juwon on 11/16/24.
//

import SwiftUI
import Combine

struct ContentView: View {
  @State private var timeRemaining = 300
  @State private var timerActive = false
  @State private var cancellable: Cancellable? = nil

    var body: some View {

      VStack(spacing: 26) {

        /// 타이머 UI
          ZStack {
            Circle()
              .fill(Color("TimerBg"))
              .frame(width: 273, height: 273)

            Circle()
              .stroke(Color("MainColor"), lineWidth: 8)
              .padding(4)
              .frame(width: 240, height: 240)

            VStack {
              Text("GCU • KHU")
                .font(.caption2)

              Text("GDG on Campus")
                .font(.title3)
                //.font(.system(size: 20))

              Text("\(formattedTime)")
                .font(.title)
                //.font(.system(size: 42))
            }

          }

        /// 시작, 리셋 버튼 구현
          HStack(spacing:12) {
            Button(action: startTimer) {
              ZStack {
                Rectangle()
                  .fill(Color("MainColor"))
                  .frame(width: 131, height: 43)
                  .cornerRadius(12)
                Text("Start")
                  .font(.body)
                  .font(.system(size:14))
                  .foregroundColor(.white)
              }
            }

            Button(action: resetTimer) {
              ZStack {
                Rectangle()
                  .fill(Color("MainColor"))
                  .frame(width: 131, height: 43)
                  .cornerRadius(12)
                Text("Reset")
                  .font(.body)
                  .font(.system(size:14))
                  .foregroundColor(.white)
              }
            }

          }
        }
        .padding()
      }

  /// 타이머 시간 형식 변경
  private var formattedTime: String {
    let minutes = timeRemaining / 60
    let seconds = timeRemaining % 60
    return String(format: "%02d:%02d", minutes, seconds)
  }

  /// 타이머 시작 함수
  private func startTimer() {
    timerActive = true
    cancellable = Timer.publish(every: 1.0, on: .main, in: .common)
      .autoconnect()
      .sink { _ in
        if timeRemaining > 0 {
          timeRemaining -= 1
        } else {
          //stop timer
          stopTimer()
        }
      }
  }

  /// 타이머 리셋 함수
  private func resetTimer() {
    //stop timer
    stopTimer()
    timeRemaining = 300
    timerActive = false
  }

  /// 타이머 멈춤 함수
  private func stopTimer() {
    cancellable?.cancel()
    cancellable = nil
  }


}

#Preview {
    ContentView()
}
