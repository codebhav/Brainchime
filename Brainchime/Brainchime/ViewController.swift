import UIKit
import ARKit

class ViewController: UIViewController {

    private let sceneView = ARSCNView(frame: UIScreen.main.bounds)
    private let model = try! VNCoreMLModel(for: CNNEmotions().model)
    private var textNode: SCNNode?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard ARWorldTrackingConfiguration.isSupported else { return }

        view.addSubview(sceneView)
        sceneView.delegate = self
        sceneView.showsStatistics = true
        sceneView.session.run(ARFaceTrackingConfiguration(), options: [.resetTracking, .removeExistingAnchors])
    }

    private func addTextNode(faceGeometry: ARSCNFaceGeometry) {
        let text = SCNText(string: "", extrusionDepth: 1)
        text.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.systemBlue
        text.materials = [material]

        let textNode = SCNNode(geometry: faceGeometry)
        textNode.position = SCNVector3(-0.1, 0.3, -0.5)
        textNode.scale = SCNVector3(0.003, 0.003, 0.003)
        textNode.geometry = text
        self.textNode = textNode
        sceneView.scene.rootNode.addChildNode(textNode)
    }

}

extension ViewController: ARSCNViewDelegate {

    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard let device = sceneView.device else { return nil }
        let node = SCNNode(geometry: ARSCNFaceGeometry(device: device))
        node.geometry?.firstMaterial?.fillMode = .lines
        return node
    }

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let faceGeometry = node.geometry as? ARSCNFaceGeometry, textNode == nil else { return }
        addTextNode(faceGeometry: faceGeometry)
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let faceAnchor = anchor as? ARFaceAnchor,
            let faceGeometry = node.geometry as? ARSCNFaceGeometry,
            let pixelBuffer = self.sceneView.session.currentFrame?.capturedImage
            else {
            return
        }

        faceGeometry.update(from: faceAnchor.geometry)

        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .right, options: [:]).perform([VNCoreMLRequest(model: model) { [weak self] request, error in
                guard let firstResult = (request.results as? [VNClassificationObservation])?.first else { return }
                DispatchQueue.main.async {
                    if firstResult.confidence > 0.92 {
                        (self?.textNode?.geometry as? SCNText)?.string = firstResult.identifier
                    }
                }
            }])
    }

}
