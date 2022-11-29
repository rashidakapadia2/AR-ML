//
//  ARViewController.swift
//  NotificationObservers
//
//  Created by Apple on 25/11/22.
//

import UIKit
import ARKit

class ARViewController: UIViewController {

    //MARK: IBOutlet
    @IBOutlet weak var arSCNView: ARSCNView!
    
    //MARK: Variable Declaration
    let configuration = ARWorldTrackingConfiguration()
    var xFloat = Float(0)
    var yFloat = Float(1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        addCone()
        addTapGestureToSceneView()
        setUpARView()
        addModel()
        
    }
    func setUpARView() {
        configuration.planeDetection = [.horizontal,.vertical]
        self.arSCNView.session.run(configuration)
        self.arSCNView.automaticallyUpdatesLighting = true
    }

    func makeNode() {
        print("adding node")
        print(xFloat,yFloat)
        addCone(x: xFloat, y: yFloat)
        xFloat += 0.1
        if yFloat > (-4) {
            yFloat -= 0.5
        } else {
            yFloat += 0.5
        }
    }
    
    func addCone(x: Float = 0.0, y: Float = 0.1, z: Float = -0.2) {
    let cone = SCNCone(topRadius: 0.0, bottomRadius: 0.04, height: 0.10)
        
    let coneNode = SCNNode()
      coneNode.geometry = cone
      coneNode.geometry?.firstMaterial?.diffuse.contents = UIColor.purple
      coneNode.position = SCNVector3(x, y, z)
      arSCNView.scene.rootNode.addChildNode(coneNode)
    }
    
    func addModel(x: Float = 0.0, y: Float = 0.1, z: Float = -0.2) {
        if let objectScene = SCNScene(named: "Model.scnassets/Parrot.scn") {
            if let objectNode: SCNNode = objectScene.rootNode.childNode(withName: "sphere", recursively: true) {
                objectNode.position = SCNVector3(x: x, y: y, z: z)
                arSCNView.scene.rootNode.addChildNode(objectNode)
                print("node added")
            }
//            print("SCNode not recognized")
        }
//        print("SCNScene not recognized")
    }
    
    func addTapGestureToSceneView() {
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap(withGestureRecognizer:)))
    arSCNView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func didTap(withGestureRecognizer recognizer: UIGestureRecognizer) {
    let tapLocation = recognizer.location(in: arSCNView)
    let hitTestResults = arSCNView.hitTest(tapLocation)
     guard let node = hitTestResults.first?.node else {
         
         if let rayCastQuery = arSCNView.raycastQuery(from: tapLocation, allowing: .existingPlaneInfinite, alignment: .any) {
             let rayCastQueryResults = arSCNView.session.raycast(rayCastQuery)
             if let results = rayCastQueryResults.first {
                 let translation = results.worldTransform.columns.3
                 
                 addModel(x: translation.x, y: translation.y, z: translation.z)
//                 print("rayCastQuery run")
//                 makeNode()
             }

         }
         
      return
    }
        print("removing node")
      node.removeFromParentNode()
    }
}
