import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            
            ZStack{
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 255/255, green: 204/255, blue: 204/255),
                        Color(red: 255/255, green: 181/255, blue: 197/255)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 80) {
                    
                    Text("Welcome to Brainchime!")
                        .font(.title)
                        .padding()
                    
                    VStack(spacing: 10) {
                        
                        HStack(spacing: 10) {
                            NavigationLink(destination: PersonalizedAssistanceView()) {
                                Text("Personalized Assistance")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color(red: 211/255, green: 111/255, blue: 131/255))
                                    .cornerRadius(10)
                            }
                            
                            NavigationLink(destination: EmotionRecognitionView()) {
                                Text("Emotion Recognition")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color(red: 211/255, green: 111/255, blue: 131/255))
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        HStack(spacing: 10) {
                            NavigationLink(destination: TaskRemindersView()) {
                                Text("Task Reminders and Scheduling")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color(red: 211/255, green: 111/255, blue: 131/255))
                                    .cornerRadius(10)
                            }
                            
                            NavigationLink(destination: NavigationAssistanceView()) {
                                Text("Navigation Assistance")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color(red: 211/255, green: 111/255, blue: 131/255))
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        NavigationLink(destination: ContentRecommendationsView()) {
                            Text("Content Recommendations")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(red: 211/255, green: 111/255, blue: 131/255))
                                .cornerRadius(10)
                        }
                        .padding(.horizontal, 20)
                        
                        NavigationLink(destination: MentalHealthSupportView()) {
                            Text("Mental Health Support")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(red: 211/255, green: 111/255, blue: 131/255))
                                .cornerRadius(10)
                        }
                        .padding(.horizontal, 20)
                    }
                    Spacer()
                }
                .padding(.vertical, 20)
            }
            .navigationTitle("Brainchime")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
