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
  // 진행률
  @State private var progress: CGFloat = 1.0
  // 회전 각도
  @State private var rotationAngle: Double = 0.0

    var body: some View {

      VStack(spacing: 26) {

        /// 타이머 UI
          ZStack {
            Circle()
              .fill(Color("TimerBg"))
              .frame(width: 273, height: 273)

            Circle()
              .stroke(Color("TimerColor"), lineWidth: 8)
              .padding(4)
              .frame(width: 240, height: 240)

            Circle()
              .trim(from: 0, to: progress)
              .stroke(Color("MainColor"), lineWidth: 8)
              .rotationEffect(.degrees(-90))
              //.rotationEffect(.degrees(rotationAngle))
              .padding(4)
              .frame(width: 240, height: 240)
              .animation(.easeInOut(duration: 0.1), value: progress)
              .animation(.easeInOut(duration: 0.1), value: rotationAngle)


            VStack(spacing: 10) {
              Text("GCU • KHU")
                .font(.caption2)
                .foregroundColor(Color.timerFont)
                .padding([.top, .bottom], 4)
                .padding([.leading, .trailing], 8)
                .background(Color.timer)
                .cornerRadius(10)

              VStack(spacing: 4) {
                Text("GDG on Campus")
                  .font(.title3)
                  .foregroundColor(Color.timerFont)

                Text("\(formattedTime)")
                  .font(.title)
                  .fontWeight(.bold)
                  .foregroundColor(Color.timerFont)
              }
            }
          }

        /// 시작, 리셋 버튼 구현
          HStack(spacing:12) {
            Button(action: startTimer) {
              ZStack {
                Rectangle()
                  .fill(timerActive ? Color("DeactiveColor") : Color("MainColor"))
                  .frame(width: 131, height: 43)
                  .cornerRadius(12)
                Text("Start")
                  .font(.body)
                  .font(.system(size:14))
                  .foregroundColor(.white)
                  .foregroundColor(timerActive ? Color.white : Color("DeactiveFontColor"))
              }
            }
            .disabled(timerActive)

            Button(action: resetTimer) {
              ZStack {
                Rectangle()
                  .fill(!timerActive ? Color("DeactiveColor") : Color("MainColor"))
                  .frame(width: 131, height: 43)
                  .cornerRadius(12)
                Text("Reset")
                  .font(.body)
                  .font(.system(size:14))
                  .foregroundColor(timerActive ? Color.white : Color("DeactiveFontColor"))
              }
            }
            .disabled(!timerActive)

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
          // 진행률 계산
          progress = CGFloat(timeRemaining) / 300.0
          // 회전 각도 계산
          rotationAngle = (1.0 - progress) * 360.0
        } else {
          //타이머 멈추기
          stopTimer()
        }
      }
  }

  /// 타이머 리셋 함수
  private func resetTimer() {
    //타이머 멈추기
    stopTimer()
    timeRemaining = 300
    timerActive = false
    progress = 1.0
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
