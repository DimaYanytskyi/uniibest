import SwiftUI

struct UpcomingItemView: View {
    @ObservedObject var navigation = Navigation.shared
    let match: Match
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Group: \(match.group?.groupName ?? "-")")
                .foregroundStyle(.white)
                .font(.system(size: 20, weight: .heavy))
            
            HStack(alignment: .center, spacing: 40) {
                VStack(alignment: .center, spacing: 10) {
                    AsyncImage(url: URL(string: match.team1?.teamIconUrl ?? "")) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                            
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                            
                        case .failure(_):
                            Image("default_club")
                                .resizable()
                                .scaledToFit()
                            
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(width: 80, height: 80)
                    
                    Text(match.team1?.shortName ?? "-")
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .heavy))
                        .lineLimit(1)
                }
                
                VStack {
                    Spacer()
                    
                    Text("-")
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .heavy))
                }
                
                VStack(alignment: .center, spacing: 10) {
                    AsyncImage(url: URL(string: match.team2?.teamIconUrl ?? "")) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                            
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                            
                        case .failure(_):
                            Image("default_club")
                                .resizable()
                                .scaledToFit()
                            
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(width: 80, height: 80)
                    
                    Text(match.team2?.shortName ?? "-")
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .heavy))
                        .lineLimit(1)
                }
            }
            
            let result = formattedDateAndTime(from: match.matchDateTimeUTC ?? "")
            Text("Date: \(result.date)\nTime: \(result.time)")
                .foregroundStyle(.white)
                .font(.system(size: 20, weight: .heavy))
                .multilineTextAlignment(.center)
        }
        .padding(13)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(Color("147B45"))
        )
    }
    
    func formattedDateAndTime(from utcString: String) -> (date: String, time: String) {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        let date = formatter.date(from: utcString) ?? ISO8601DateFormatter().date(from: utcString)
        
        guard let date = date else {
            return ("-", "-")
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current

        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormatter.string(from: date)

        dateFormatter.dateFormat = "HH:mm:ss"
        let timeString = dateFormatter.string(from: date)

        return (dateString, timeString)
    }
}
