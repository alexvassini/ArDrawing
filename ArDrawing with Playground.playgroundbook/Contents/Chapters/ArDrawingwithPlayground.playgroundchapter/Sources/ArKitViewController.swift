
//  Created by Alexandre  Vassinievski on 28/02/2018.
//  Copyright © 2018 Vassini. All rights reserved.
//

import Foundation
import UIKit
import SceneKit
import ARKit

@available(iOS 11.0, *)
public class ArKitViewController: UIViewController, ARSessionDelegate, ARSCNViewDelegate {
  var sceneView: ARSCNView!
  var drawButton: UIButton!
  let session = ARSession()
  var previousPoint: SCNVector3?
  var pointArray: [SCNVector3] = []
  var nodeArray: [SCNNode] = []
  
  //************
  var gestureBeganFlag = false
  var spawnLine = false
  var spawnTime:TimeInterval = 0
  
  
  var lineColor = UIColor.white
  
  public var settings = Settings()
  
  override public func loadView() {
  
    sceneView = ARSCNView(frame: CGRect(x: 0.0, y: 0.0, width: 500.0, height: 600.0))

    sceneView.delegate = self
    sceneView.session.delegate = self
    sceneView.session = session
    sceneView.showsStatistics = true

    let scene = SCNScene()
    sceneView.scene = scene

    let config = ARWorldTrackingConfiguration()

    // lighting
    let nonAmbientLightNode = SCNNode()
    nonAmbientLightNode.light = SCNLight()
    nonAmbientLightNode.light?.type = .ambient
    nonAmbientLightNode.light?.color = UIColor.white
    nonAmbientLightNode.light?.intensity = 500
    sceneView.scene.rootNode.addChildNode(nonAmbientLightNode)
    
    // setup camera
    let cameraNode = SCNNode()
    cameraNode.camera = SCNCamera()
    cameraNode.position = SCNVector3(x: 10, y: 10, z: 10)
    sceneView.scene.rootNode.addChildNode(cameraNode)

    self.view = sceneView
    sceneView.session.run(config, options: [.removeExistingAnchors])

  }
  
  // Show fps and node count
  func showSceneStatistics(_ show: Bool){
    sceneView.showsStatistics = show
  }
  
  override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.gestureBeganFlag = true
  }
  
  override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.gestureBeganFlag = false
  }

  // MARK: - ARSCNViewDelegate
  public func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
    DispatchQueue.main.async {
      if time > self.spawnTime {
        self.spawnLine = true
        self.spawnTime = time + TimeInterval(0.008)
      }
      else {self.spawnLine = false}
    }
  }
  
  public  func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
    
    if gestureBeganFlag && spawnLine  {
      guard let currentPosition = drawLine() else { return }
      for p in 0..<pointArray.count{
        let historyPoint = pointArray[p]
        let randomNumber = arc4random_uniform(100)
        let distance  = Double(historyPoint.distance(vector: currentPosition))
        
        if (distance < settings.threshold && randomNumber > 80)
        {
          let color = settings.rainbowEnabled ? settings.getNextColorHUE() : settings.secondaryLineColor
          let lineNode = SCNNode.lineNode(from: currentPosition, to: historyPoint, color: color, radius: settings.secondaryLineWidth)
          sceneView.scene.rootNode.addChildNode(lineNode)
        }
      }
      pointArray.append(currentPosition)
      if pointArray.count > 800 {
        pointArray.removeFirst()
        
      }
    }
  }
  
  func drawLine() -> SCNVector3?{
    
    if let pointOfView = sceneView.pointOfView {
      let mat = pointOfView.transform
      let dir = SCNVector3(-1 * mat.m31, -1 * mat.m32, -1 * mat.m33)
      let currentPosition = pointOfView.position + (dir * 0.5)
      
      if let previousPoint = pointArray.last {
        let color = settings.rainbowEnabled ? settings.getNextColorHUE() : settings.primaryLineColor
        let lineNode = SCNNode.lineNode(from: previousPoint, to: currentPosition, color: color, radius: settings.primaryLineWidth)
        sceneView.scene.rootNode.addChildNode(lineNode)
      }
      return currentPosition
    }
    else {return nil}
  }
  
}

