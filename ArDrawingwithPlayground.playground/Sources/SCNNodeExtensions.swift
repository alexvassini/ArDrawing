
import Foundation
import SceneKit

extension SCNNode {
  
  static func lineNode(from: SCNVector3, to: SCNVector3, color: UIColor, radius: CGFloat = 0.05) -> SCNNode {
    let vector = to - from
    let height = vector.length()
    
    let cylinder = SCNCylinder(radius: radius, height: CGFloat(height))
    cylinder.firstMaterial?.diffuse.contents = color
    let node = SCNNode(geometry: cylinder)
    node.position = (to + from) / 2
    node.eulerAngles = SCNVector3.lineEulerAngles(vector: vector)
    return node
  }
}
