//
//  GameViewController.swift
//  BDV
//
//  Created by Brian Thompson on 2/20/16.
//  Copyright (c) 2016 Brian Thompson. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit


var scene: SCNScene!
var patientSelected: Patient!
var patientNames = [String: Patient]()
var sectDict = [String: Section]()

var bodyDict: [String: String] = ["chest":"ID107", "abdominal":"ID107", "coronary":"ID107", "heart":"ID107", "respiratory":"ID107", "herpes":"ID107", "renal":"ID107", "gonorrhea":"ID107", "back": "ID107", "cardiac": "ID107", "lung": "ID107", "kidney":"ID107", "vagina":"ID107", "rip":"ID76", "knee":"ID76", "shoulder":"GM_-_Upper_Arm", "arm":"GM_-_Upper_Arm", "hip":"ID107", "foot":"GM_-_Foot", "head":"GM_-_Head", "headache":"GM_-_Head", "thigh":"ID76"]




//var patients = [Patient]()
//var patientCreater = PatientCreater()

func animate(material: SCNMaterial){
    // highlight it
    SCNTransaction.begin()
    SCNTransaction.setAnimationDuration(0.5)
    
    // on completion - unhighlight
    SCNTransaction.setCompletionBlock {
        SCNTransaction.begin()
        SCNTransaction.setAnimationDuration(0.5)
        
        material.emission.contents = UIColor.blackColor()
        
        SCNTransaction.commit()
    }
    
    material.emission.contents = UIColor.redColor()
    
    SCNTransaction.commit()
}


func colorParts(){
    for section in patientSelected.Sections{
        let search = section.enteredName
        let fullNameArr = search.componentsSeparatedByString(" ")
        for word in fullNameArr{
            if bodyDict[word] != nil{
                let node = scene.rootNode.childNodeWithName("\(bodyDict[word]!)", recursively: true)
                let material = node!.geometry!.firstMaterial!
                material.emission.contents = UIColor.redColor()
                sectDict[bodyDict[word]!]=section
            }
        }
    }
}


func initMan(){
    let headScene = SCNScene(named: "art.scnassets/Head.dae")
    let headNode = headScene!.rootNode.childNodes[0]
    scene.rootNode.addChildNode(headNode)
    let   lArm = SCNScene(named: "art.scnassets/lArm.dae")
    scene.rootNode.addChildNode(lArm!.rootNode)
    let   lCalf = SCNScene(named: "art.scnassets/lCalf.dae")
    scene.rootNode.addChildNode(lCalf!.rootNode)
    let   lFoot = SCNScene(named: "art.scnassets/lFoot.dae")
    scene.rootNode.addChildNode(lFoot!.rootNode)
    let   lShoulder = SCNScene(named: "art.scnassets/lShoulder.dae")
    scene.rootNode.addChildNode(lShoulder!.rootNode)
    let   lThigh = SCNScene(named: "art.scnassets/lThigh.dae")
    scene.rootNode.addChildNode(lThigh!.rootNode)
    let   rArm = SCNScene(named: "art.scnassets/rArm.dae")
    scene.rootNode.addChildNode(rArm!.rootNode)
    let   rCalf = SCNScene(named: "art.scnassets/rCalf.dae")
    scene.rootNode.addChildNode(rCalf!.rootNode)
    let   rFoot = SCNScene(named: "art.scnassets/rFoot.dae")
    scene.rootNode.addChildNode(rFoot!.rootNode)
    let   rShoulder = SCNScene(named: "art.scnassets/rShoulder.dae")
    scene.rootNode.addChildNode(rShoulder!.rootNode)
    let   rThigh = SCNScene(named: "art.scnassets/rThigh.dae")
    scene.rootNode.addChildNode(rThigh!.rootNode)
}

//func initPatient(){
//    patientCreater.readDataBase(patients)
//}


//, returnPatientArray
class GameViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        
                
//        patientCreater = PatientCreater()
//        patientCreater.delegate = self
        
        // create a new scene
        scene = SCNScene(named: "art.scnassets/Body.dae")!
        let body = scene.rootNode
        initMan()
        colorParts()
        
        
        //        ship.geometry?.firstMaterial?.diffuse.contents = UIColor.redColor()
        
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        
        let constraint = SCNLookAtConstraint(target: body)
        
        cameraNode.constraints = [constraint]
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 90)
        
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLightTypeOmni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        //        scene.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLightTypeAmbient
        ambientLightNode.light!.color = UIColor.darkGrayColor()
        scene.rootNode.addChildNode(ambientLightNode)
        
        // retrieve the ship node
        
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        
        
        // configure the view
        scnView.backgroundColor = UIColor.whiteColor()
        
        scnView.autoenablesDefaultLighting = true
        
        // add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: "handleTap:")
        scnView.addGestureRecognizer(tapGesture)
    }
    
    func handleTap(gestureRecognize: UIGestureRecognizer) {
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // check what nodes are tapped
        let p = gestureRecognize.locationInView(scnView)
        let hitResults = scnView.hitTest(p, options: nil)
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result: AnyObject! = hitResults[0]
            
            
//            print(result.node.name!)
            if sectDict[result.node.name!] != nil{
                let section = sectDict[result.node.name!]
                print(section)
                let ac = UIAlertController(title: section!.enteredName, message: "Translation name: "+section!.translationName+"\nIMO LEXICAL CODE: "+section!.IMO_LEXICAL_CODE+"\nICD10CM_CODE: "+section!.ICD10CM_CODE+"\nEntered Date: "+section!.enteredDate, preferredStyle: .ActionSheet)
                
                let popover = ac.popoverPresentationController
                popover?.sourceView = view
                popover?.sourceRect = CGRect(x: p.x, y: p.y, width: 70, height: 60)
                
                presentViewController(ac, animated: true, completion: nil)
            }
            
            
            
            
        }
    }
    
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
}
