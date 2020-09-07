//
//  MissionView.swift
//  MoonShot
//
//  Created by George Solorio on 9/6/20.
//  Copyright © 2020 George Solorio. All rights reserved.
//

import SwiftUI

struct MissionView: View {
    
    struct CrewMembers {
        let role: String
        let astronaut: Astronaut
    }
    
    let astronauts: [CrewMembers]
    let mission: Mission
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack {
                    Image(self.mission.image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: geo.size.width * 0.7 )
                    .padding()
                    
                    
                    ForEach(self.astronauts, id: \.role) {
                        crewMember in
                        
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 83, height: 60)
                                .clipShape(Capsule())
                                    .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        var matches = [CrewMembers]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name}) {
                
                matches.append(CrewMembers(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        self.astronauts = matches
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}