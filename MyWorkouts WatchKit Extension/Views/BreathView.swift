//
//  BreathView.swift
//  B-Kuik WatchKit App
//
//  Created by Deka Primatio on 23/05/23.
//  Copyright © 2023 Apple. All rights reserved.
//

import SwiftUI
import WatchKit

struct BreathView: View {
    //MARK: - PROPERTIES
    @EnvironmentObject var workoutManager: WorkoutManager
    @Environment(\.dismiss) var dismiss
    
    @State private var grow = false
    @State private var rotateFarRight = false
    @State private var rotateFarLeft = false
    @State private var rotateMiddleLeft = false
    @State private var rotateMiddleRight = false
    @State private var showShadow = false
    @State private var showRightStroke = false
    @State private var showLeftStroke = false
    @State private var changeColor = false
    @State private var breatheIn = false
    @State private var breatheOut = true
    
    @State private var timerSeconds = 10
    @State private var timer: Timer?
    @State private var navigateToSummary = false
    
    //MARK: - BODY
    var body: some View {
        VStack {
            
            Spacer()
            
            Spacer()
            
            ZStack {
                
                Image("Petal") // Middle
                    .scaleEffect(grow ? 0.6 : 0.5, anchor: .bottom)
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true)) {
                            grow.toggle()
                        }
                    }
                
                
                Image("Petal")  // Middle left
                    .scaleEffect(grow ? 0.6 : 0.5, anchor: .bottom)
                    .rotationEffect(.degrees( rotateMiddleLeft ? -25 : -5), anchor: .bottom)
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true)) {
                            rotateMiddleLeft.toggle()
                        }
                    }
                
                
                Image("Petal")  // Middle right
                    .scaleEffect(grow ? 0.6 : 0.5, anchor: .bottom)
                    .rotationEffect(.degrees( rotateMiddleRight ? 25 : 5), anchor: .bottom)
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true)) {
                            rotateMiddleRight.toggle()
                        }
                    }
                
                Image("Petal")  // Left
                    .scaleEffect(grow ? 0.6 : 0.5, anchor: .bottom)
                    .rotationEffect(.degrees( rotateFarLeft ? -50 : -10), anchor: .bottom)
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true)) {
                            rotateFarLeft.toggle()
                        }
                    }
                
                Image("Petal")  // Right
                    .scaleEffect(grow ? 0.6 : 0.5, anchor: .bottom)
                    .rotationEffect(.degrees( rotateFarRight ? 50 : 10), anchor: .bottom)
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true)) {
                            rotateFarRight.toggle()
                        }
                    }
                
                Circle()  // Quarter dotted circle left
                    .trim(from: showLeftStroke ? 0 : 1/4, to: 1/4)
                    .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round, dash: [2, 16]))
                    .frame(width: 150, height: 65, alignment: .center)
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .rotationEffect(.degrees(-180), anchor: .center)
                    .offset(x: 0, y: -15)
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true)) {
                            showLeftStroke.toggle()
                        }
                    }
                
                Circle()  // Quarter dotted circle right
                    .trim(from: 0, to: showRightStroke ? 1/3.5 : 0)
                    .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round, dash: [2, 15]))
                    .frame(width: 150, height: 65, alignment: .center)
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .rotationEffect(.degrees(-90), anchor: .center)
                    .offset(x: 0, y: -15)
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true)) {
                            showRightStroke.toggle()
                        }
                    }
                
            } // Container for Petal
            .shadow(radius: showShadow ? 20 : 0) // Switching from flat to elevation
            .hueRotation(Angle(degrees: changeColor ? -45 : 45)) // Animating Chroma
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true)) {
                    changeColor.toggle()
                    showShadow.toggle()
                }
            }
            
            ZStack {
                Text("Breathe In")
                    .opacity(breatheIn ? 0 : 1)
                    .scaleEffect(breatheIn ? 0 : 1, anchor: .center)
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true)) {
                            breatheIn.toggle()
                        }
                    }
                
                Text("Breathe Out")
                    .opacity(breatheOut ? 0 : 1) // Opacity animation
                    .scaleEffect(breatheOut ? 0 : 1, anchor: .center)
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true)) {
                            breatheOut.toggle()
                        }
                    }
            }
            .padding(.top, 5)
            .font(.system(size: 16, weight: .bold))
            
            Spacer()
            
            Text("\(timerSeconds)")
                .font(.system(size: 16, weight: .semibold))
                .background(
                    Circle()
                        .fill(Color("ColorCherryDark"))
                        .frame(width: 30, height: 30)
                )
                .padding(.top, 10)
        } // VStack (Main Wrapper)
        .onAppear {
            startTimer()
        }
        .fullScreenCover(isPresented: $navigateToSummary) {
            SummaryPagingView()
                .navigationBarBackButtonHidden(true)
        }
        
    }//: - BODY
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timerSeconds > 0 {
                timerSeconds -= 1
            } else {
                timer?.invalidate()
                navigateToSummary = true
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
    }
}

//MARK: - PREVIEW
struct BreathView_Previews: PreviewProvider {
    static var previews: some View {
        BreathView()
    }
}
