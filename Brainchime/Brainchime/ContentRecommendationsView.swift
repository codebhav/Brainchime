import SwiftUI

struct Recommendation {
    var title: String
    var description: String
}

struct ContentRecommendationsListView: View {
    var recommendations: [Recommendation]
    
    var body: some View {
            List(recommendations, id: \.title) { recommendation in
                NavigationLink(destination: ContentRecommendationsDetailView(recommendation: recommendation)) {
                    Text(recommendation.title)
                }
            }
            .navigationTitle("Recommendations!")
    }
}

struct ContentRecommendationsDetailView: View {
    var recommendation: Recommendation
    
    var body: some View {
        VStack {
            
            Text(recommendation.title)
                .font(.title)
                .padding()
            Text(recommendation.description)
                .padding()
            Spacer()
        }
        .navigationTitle(recommendation.title)
    }
}

struct ContentRecommendationsView: View {
    var recommendations: [Recommendation] = [
        Recommendation(title: "Recommendation 1", description: "This is recommendation 1"),
        Recommendation(title: "Recommendation 2", description: "This is recommendation 2"),
        Recommendation(title: "Recommendation 3", description: "This is recommendation 3")
    ]
    
    var body: some View {
        NavigationView {
            ContentRecommendationsListView(recommendations: recommendations)
        }
    }
}

struct ContentRecommendationsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentRecommendationsView()
    }
}
