//
//  ContentView.swift
//  JokeAppSwiftUI
//
//  Created by Đorđije Novović on 10.1.21..
//

import SwiftUI

struct ContentView: View {
    
    @State private var jokeData: JokeData?
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "face.smiling.fill")
                .foregroundColor(.accentColor)
                .font(.largeTitle)
                .scaleEffect(2)
                .padding()
            Spacer()
            
            Text(jokeData?.setup ?? "")
                .foregroundColor(.accentColor)
                .font(.title)
                .fontWeight(.bold)
                .padding()
                .animation(.easeIn)
            Spacer()
            Text(jokeData?.punchline ?? "")
                .foregroundColor(.white)
                .font(.title3)
                .padding()
                .background(Color.accentColor)
                .cornerRadius(16)
                .animation(.easeIn)
            Spacer()
            Button(action: {
                loadData()
            }, label: {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
            })
            .font(.largeTitle)
            .scaleEffect(2)
            .padding()
            Spacer()
        }
        .multilineTextAlignment(.center)
        .onAppear(perform: {
            loadData()
        })
    }
    
    private func loadData() {
        
        guard let url = URL(string: "https://official-joke-api.appspot.com/jokes/random") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            if let decodedData = try? JSONDecoder().decode(JokeData.self, from: data) {
                DispatchQueue.main.async {
                    self.jokeData = decodedData
                }
            }
        }.resume()
    }
}



struct JokeData: Decodable {
    var id: Int
    var type: String
    var setup: String
    var punchline: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
