import SwiftUI

struct GameRulesView : View {
    @ObservedObject var navigation = Navigation.shared
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(RoundedRectangle(cornerRadius: 28)
                        .fill(.white.opacity(0.45)))
                    .onTapGesture {
                        navigation.navigateBack()
                    }
                
                Text("Game Rules")
                    .foregroundStyle(.white)
                    .font(.system(size: 24, weight: .heavy))
                
                Spacer()
            }
            .padding()
            .background(Color("147B45"))
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Football Game Rules")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("1. Objective of the Game")
                        .font(.headline)
                    Text("The main goal is to score more goals than the opposing team by getting the ball into their net. The team with the most goals at the end of the match wins.")
                    
                    Text("2. Number of Players")
                        .font(.headline)
                    Text("Each team has 11 players on the field, including 1 goalkeeper. Substitutes are allowed depending on the competition rules.")
                    
                    Text("3. Duration of the Match")
                        .font(.headline)
                    Text("A standard match consists of two 45-minute halves with a 15-minute halftime break. Additional stoppage time may be added to compensate for injuries and other delays.")
                    
                    Text("4. Starting the Game")
                        .font(.headline)
                    Text("The game starts with a kick-off from the center circle. The same applies after a goal is scored.")
                    
                    Text("5. Ball In and Out of Play")
                        .font(.headline)
                    Text("The ball is out of play when it fully crosses the goal line or touchline. It is in play at all other times, including if it rebounds off goalposts or the referee.")
                    
                    Text("6. Offside Rule")
                        .font(.headline)
                    Text("A player is offside if they are closer to the opponent’s goal line than both the ball and the second-last defender when the ball is played to them, unless they are in their own half.")
                    
                    Text("7. Fouls and Misconduct")
                        .font(.headline)
                    Text("Players commit fouls by tripping, pushing, or handling the ball deliberately. Serious fouls can result in yellow or red cards, leading to cautions or ejections.")
                    
                    Text("8. Free Kicks and Penalties")
                        .font(.headline)
                    Text("Free kicks are awarded for fouls and can be direct or indirect. Penalty kicks are awarded when a foul occurs in the penalty area.")
                    
                    Text("9. Throw-ins, Goal Kicks, and Corner Kicks")
                        .font(.headline)
                    Text("A throw-in is awarded when the ball crosses the touchline. A goal kick is awarded when the attacking team last touches the ball before it crosses the goal line. A corner kick is given when the defending team last touches it.")
                    
                    Text("10. Winning the Game")
                        .font(.headline)
                    Text("The team that scores the most goals during the match wins. If the score is tied, the game may end in a draw or go to extra time or penalties, depending on the competition.")
                    
                    Text("Enjoy the game and play fair!")
                        .font(.body)
                        .italic()
                        .padding(.top, 8)
                }
                .padding()
                .foregroundColor(.white)
            }
        }
    }
}

