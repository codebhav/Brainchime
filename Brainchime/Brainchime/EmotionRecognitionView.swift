import SwiftUI
import ARKit

struct EmotionRecognitionView: UIViewControllerRepresentable {
    typealias UIViewControllerType = ViewController
    
    func makeUIViewController(context: Context) -> ViewController {
        let vc = ViewController()
        return vc
    }
        
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        
    }
}

struct EmotionRecognitionView_Previews: PreviewProvider {
    static var previews: some View {
        EmotionRecognitionView()
    }
}
