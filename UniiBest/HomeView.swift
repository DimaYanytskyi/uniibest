import SwiftUI

struct HomeView: View {
    @ObservedObject var navigation = Navigation.shared
    
    var body: some View {
        VStack {
            HStack {
                Text("HI, Football Lover!")
                    .foregroundStyle(.white)
                    .font(.system(size: 24, weight: .heavy))
                
                Spacer()
                
                Image(systemName: "gearshape")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(RoundedRectangle(cornerRadius: 28)
                        .fill(.white.opacity(0.45)))
                    .onTapGesture {
                        navigation.navigate(to: .settings)
                    }
                    
            }
            .padding()
            .background(Color("147B45"))
            
            ScrollView {
                VStack(spacing: 20) {
                    HStack(spacing: 20) {
                        VStack(spacing: 10) {
                            Image("home_matches")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100)
                            
                            Text("Matches")
                                .foregroundStyle(.white)
                                .font(.system(size: 24, weight: .heavy))
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color("147B45"))
                        )
                        .onTapGesture {
                            navigation.navigate(to: .matches)
                        }
                        
                        VStack(spacing: 10) {
                            Image("home_teams")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                            
                            Text("Teams")
                                .foregroundStyle(.white)
                                .font(.system(size: 24, weight: .heavy))
                        }
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color("147B45"))
                        )
                        .onTapGesture {
                            navigation.navigate(to: .teams)
                        }
                    }
                    
                    HStack(spacing: 20) {
                        VStack(spacing: 10) {
                            Image("home_upcoming_matches")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100)
                            
                            Text("Upcoming Matches")
                                .foregroundStyle(.white)
                                .font(.system(size: 24, weight: .heavy))
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color("147B45"))
                        )
                        .onTapGesture {
                            navigation.navigate(to: .upcomingMatches)
                        }
                        
                        VStack(spacing: 10) {
                            Image("home_favorite_teams")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60)
                            
                            Text("Favorite Teams")
                                .foregroundStyle(.white)
                                .font(.system(size: 24, weight: .heavy))
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color("147B45"))
                        )
                        .onTapGesture {
                            navigation.navigate(to: .favoriteTeams)
                        }
                    }
                    
                    HStack {
                        Image("home_penalty_maker")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 80)
                        
                        Spacer()
                        
                        Text("Penalty Maker")
                            .font(.system(size: 24, weight: .heavy))
                            .foregroundStyle(.white)
                            .frame(maxWidth: 100)
                            .multilineTextAlignment(.center)
                        
                    }
                    .padding(.horizontal, 32)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color("147B45"))
                    )
                    .onTapGesture {
                        navigation.navigate(to: .penaltyMaker)
                    }
                    
                    HStack {
                        Image("home_game_rules")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 80)
                        
                        Spacer()
                        
                        Text("Game Rules")
                            .font(.system(size: 24, weight: .heavy))
                            .foregroundStyle(.white)
                            .frame(maxWidth: 100)
                            .multilineTextAlignment(.center)
                        
                    }
                    .padding(.horizontal, 32)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color("147B45"))
                    )
                    .onTapGesture {
                        navigation.navigate(to: .gameRules)
                    }
                }
                .padding(32)
            }
        }
        .frame(maxWidth: .infinity)
        .onAppear {
            OrientationLock.set(.portrait)
            OrientationHelper.forceOrientation(.portrait)
        }
    }
}
