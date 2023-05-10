import SwiftUI

struct NavigationAssistanceView: View {
    
    var body: some View {
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
                
                Text("Navigation Assistance View in Development")
        }
    }
}

struct NavigationAssistanceView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationAssistanceView()
    }
}
