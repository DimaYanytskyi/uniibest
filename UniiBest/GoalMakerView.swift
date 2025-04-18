import SwiftUI

struct GoalMakerView: View {
    @ObservedObject var navigation = Navigation.shared
    
    @AppStorage("currentGoals") private var currentGoals = 0
    @AppStorage("maxSeriesOfGoals") private var maxSeriesOfGoals: Int = 0
    
    @State private var selectedTarget: Int? = nil
    @State private var goalkeeperPosition: Int = 5
    @State private var showGoalkeeper = false
    @State private var showCountdown = false
    @State private var countdown = 3
    @State private var resultMessage: String? = nil
    @State private var showResultMessage = false
    @State private var ballOffset: CGSize = .zero
    @State private var showInfoAlert = false
    @State private var isCountingDown = false
    
    let targetPositions: [CGPoint] = [
        CGPoint(x: 0.32, y: 0.3),
        CGPoint(x: 0.5, y: 0.3),
        CGPoint(x: 0.68, y: 0.3),
        CGPoint(x: 0.32, y: 0.65),
        CGPoint(x: 0.68, y: 0.65),
        CGPoint(x: 0.5, y: 0.65),
    ]

    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 18) {
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(RoundedRectangle(cornerRadius: 28).fill(.white.opacity(0.45)))
                    .onTapGesture { navigation.navigateBack() }

                Image(systemName: "info")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(RoundedRectangle(cornerRadius: 28).fill(.white.opacity(0.45)))
                    .onTapGesture { showInfoAlert = true }

                Spacer()

                VStack(spacing: 10) {
                    Text("Choose the point")
                        .foregroundStyle(.white)
                        .font(.system(size: 24, weight: .semibold))
                }

                Spacer()

                VStack(alignment: .leading, spacing: 10) {
                    Text("Goals: \(currentGoals)")
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .semibold))
                    
                    Text("Max series: \(maxSeriesOfGoals)")
                        .foregroundStyle(.white)
                        .font(.system(size: 16, weight: .semibold))
                }
            }
            .padding()

            ZStack {
                GeometryReader { geo in
                    ForEach(0..<targetPositions.count - 1, id: \.self) { index in
                        Circle()
                            .fill(index == selectedTarget ? Color.green.opacity(0.8) : Color.red.opacity(0.6))
                            .frame(width: 60, height: 60)
                            .position(x: geo.size.width * targetPositions[index].x,
                                      y: geo.size.height * targetPositions[index].y)
                            .onTapGesture {
                                handleTap(on: index, width: geo.size.width, height: geo.size.height)
                            }
                    }

                    
                    Image(showGoalkeeper ? "catching" : "waiting")
                        .resizable()
                        .frame(width: showGoalkeeper ? 60 : 80, height: showGoalkeeper ? 140 : 100)
                        .position(x: geo.size.width * targetPositions[goalkeeperPosition].x,
                                  y: geo.size.height * targetPositions[goalkeeperPosition].y)
                        .transition(.scale)
                    
                    if showResultMessage, let resultMessage {
                        Text(resultMessage)
                            .font(.system(size: 48, weight: .bold))
                            .foregroundColor(.white)
                            .transition(.opacity)
                            .position(x: geo.size.width / 2, y: 0)
                    }
                    
                    if showCountdown {
                        Text("\(countdown)")
                            .font(.system(size: 64, weight: .bold))
                            .foregroundColor(.white)
                            .position(x: geo.size.width / 2, y: 0)
                    }

                    Image("ball")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .position(x: geo.size.width / 2, y: geo.size.height * 0.9)
                        .offset(ballOffset)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("goal_background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        )
        .onAppear {
            OrientationLock.set(.landscapeRight)
            OrientationHelper.forceOrientation(.landscapeRight)
        }
        .alert(isPresented: $showInfoAlert) {
            Alert(
                title: Text("How to Play"),
                message: Text("Choose the red dot – it's the spot where you will strike the ball. If the goalkeeper doesn't catch the ball, you score points. Try to score as many goals in a row as possible!"),
                dismissButton: .default(Text("Got it!"))
            )
        }
    }

    func handleTap(on index: Int, width: CGFloat, height: CGFloat) {
        guard !isCountingDown else { return }
        isCountingDown = true
        selectedTarget = index
        showCountdown = true
        countdown = 3

        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            countdown -= 1
            if countdown == 0 {
                timer.invalidate()
                showCountdown = false
                kickBall(to: index, width: width, height: height)
            }
        }
    }

    func kickBall(to index: Int, width: CGFloat, height: CGFloat) {
        withAnimation(.easeIn(duration: 0.4)) {
            goalkeeperPosition = Int.random(in: 0..<targetPositions.count-1)
        }
        showGoalkeeper = true

        let ballStart = CGPoint(x: width / 2, y: height * 0.85)
        let target = CGPoint(x: width * targetPositions[index].x,
                             y: height * targetPositions[index].y)

        let offset = CGSize(width: target.x - ballStart.x,
                            height: target.y - ballStart.y)

        withAnimation(.easeIn(duration: 0.4)) {
            ballOffset = offset
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            evaluateGoal(at: index)
            withAnimation(.easeOut(duration: 0.3)) {
                ballOffset = .zero
            }
        }
    }

    func evaluateGoal(at index: Int) {
        if index == goalkeeperPosition {
            resultMessage = "Try Again"
            currentGoals = 0
        } else {
            resultMessage = "You Scored!"
            currentGoals += 1
            if currentGoals > maxSeriesOfGoals {
                maxSeriesOfGoals = currentGoals
            }
        }

        showResultMessage = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            showResultMessage = false
            showGoalkeeper = false
            goalkeeperPosition = 5
            selectedTarget = nil
            resultMessage = nil
            isCountingDown = false
        }
    }
}
