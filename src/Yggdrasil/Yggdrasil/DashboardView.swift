import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            ParchmentBackground()
            
            VStack(spacing: 0) {
                // Top Header Section
                VStack(spacing: 4) {
                    Text("THE HORUS HERESY")
                        .font(.custom("Palatino-Bold", size: 14))
                        .tracking(4)
                    
                    // The "Double Bar" typical of Forge World layouts
                    Rectangle().frame(height: 3)
                    Rectangle().frame(height: 1).padding(.top, 1)
                }
                .padding(.horizontal, 25)
                .padding(.top, 60)
                
                // Content Body
                VStack(alignment: .leading, spacing: 25) {
                    
                    // Main Title
                    Text(appState.isTournamentActive ? "BATTLE DISPOSITION" : "MUSTER OF FORCES")
                        .font(.custom("Palatino-Bold", size: 34))
                        .foregroundColor(.black)
                    
                    // Status Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("STRATEGIC STATUS")
                            .font(.custom("Helvetica-Bold", size: 12)) // Black books often mix sans-serif for labels
                            .tracking(1)
                            .foregroundColor(.heresyRed)
                        
                        Text(appState.isTournamentActive ? "ACTIVE CONFLICT" : "STAGING PHASE")
                            .font(.custom("Palatino", size: 22))
                    }
                    
                    // Statistics Section with the "Side Bar" look
                    HStack(spacing: 0) {
                        Rectangle()
                            .frame(width: 4)
                            .foregroundColor(.black.opacity(0.8))
                        
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("LEGIONS REGISTERED:")
                                    .font(.custom("Palatino-Bold", size: 14))
                                Spacer()
                                Text("\(appState.registeredPlayers)")
                                    .font(.custom("Palatino-Bold", size: 18))
                            }
                            
                            if appState.isTournamentActive {
                                HStack {
                                    Text("CURRENT THEATRE:")
                                        .font(.custom("Palatino-Bold", size: 14))
                                    Spacer()
                                    Text("ROUND \(appState.currentRound)")
                                        .font(.custom("Palatino-Bold", size: 18))
                                }
                            }
                        }
                        .padding(.leading, 15)
                    }
                    .padding(.vertical, 10)
                    
                    // Divider
                    Rectangle().frame(height: 1).opacity(0.3)
                    
                    // Flavor Text
                    Text("The records of the XIVth Legion at Istvaan III show a total breakdown of command protocols following the initial viral bombardment.")
                        .font(.custom("Palatino-Italic", size: 16))
                        .lineSpacing(4)
                        .opacity(0.8)
                }
                .padding(30)
                .foregroundColor(.black)
                
                Spacer()
                
                // Page Number / ID Tag at bottom
                Text("LIBER HISTORICA // VOL. CLXXIV")
                    .font(.custom("Courier", size: 10))
                    .padding(.bottom, 30)
                    .opacity(0.5)
            }
        }
    }
}
