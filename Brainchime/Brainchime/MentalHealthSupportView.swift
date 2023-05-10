import SwiftUI

struct MentalHealthSupportView: View {
    
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
                
                Text("Mental Health Support View in Development")
        }
    }
}

struct MentalHealthSupportView_Previews: PreviewProvider {
    static var previews: some View {
        MentalHealthSupportView()
    }
}
