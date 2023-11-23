//
//  Coordinator.swift
//  Measure
//
//  Created by Francesca Ferrini on 22/11/23.
//

import Foundation
import RealityKit
import SwiftUI
import ARKit

class Coordinator: NSObject, ARCoachingOverlayViewDelegate{
    
    var arView: ARView?
    
    
    var anchorPoint1:AnchorEntity?
    var anchorPoint2:AnchorEntity?
    var measurementButton:UIButton = UIButton(configuration: .filled())
    var resetButton:UIButton = UIButton(configuration: .gray())
        
    @objc func handleTap(_ recognizer: UITapGestureRecognizer){
        
        guard let arView = arView else { return }
        
        if (anchorPoint2 == nil)
        {
            // The user tapping on the screen initiates a Raycast, and the hit results are stored in results as an array of type [ARRaycastResult]
            let tappedLocation = recognizer.location(in: arView)
            
            let results = arView.raycast(from: tappedLocation, allowing: .estimatedPlane, alignment: .horizontal)
            
            //Exit the function if the Raycast is unsuccessful i.e. user did not tap on a point on the detected plane
            if results.isEmpty {
                return
            }
            
            let sphere = ModelEntity(mesh: MeshResource.generateSphere(radius: 0.01), materials: [SimpleMaterial(color: UIColor.white, isMetallic: false)])
            
            if (anchorPoint1 == nil)
            {
                //An anchor is created at the point where the user tapped
                //Sphere model is attached to the anchor and the anchor is added to the scene
                anchorPoint1 = (AnchorEntity(raycastResult: results[0]))
                anchorPoint1?.addChild(sphere)
                arView.scene.addAnchor(anchorPoint1!)
            }
            else
            {
                //Second anchor point is added here
                anchorPoint2 = (AnchorEntity(raycastResult: results[0]))
                anchorPoint2?.addChild(sphere)
                arView.scene.addAnchor(anchorPoint2!)
                
                // Since the user has selected two points, we can calculate the distance between bpth anchor positions and relay it back to the user
                let distance = simd_distance(anchorPoint1!.position(relativeTo: nil), anchorPoint2!.position(relativeTo: nil))
                let measurement = String(format: "%.2f m",distance)
                
                measurementButton.setTitle(measurement, for: .normal)
                measurementButton.setTitleColor(UIColor.blue, for: .normal)
            }
        }
    }
    
    func setupUI() {
        guard let arView = arView else { return }

   
        let stackView = UIStackView(arrangedSubviews: [measurementButton, resetButton])

        stackView.axis = .horizontal
        stackView.spacing = 150
        stackView.translatesAutoresizingMaskIntoConstraints = false

        measurementButton.setTitle("0 m", for: .normal)
        measurementButton.isUserInteractionEnabled = false
        measurementButton.configuration?.baseBackgroundColor = UIColor.lightGray
        measurementButton.frame.size = CGSize(width: 100, height: 70)
        measurementButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        measurementButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        

        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.setImage(UIImage(systemName: "trash.square.fill"), for: .normal)
        resetButton.tintColor = UIColor.white
        resetButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        resetButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        resetButton.heightAnchor.constraint(equalToConstant: 44).isActive = true

        arView.addSubview(stackView)

        stackView.centerXAnchor.constraint(equalTo: arView.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: arView.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

    @objc func buttonAction(_ sender:UIButton!) {
        anchorPoint1 = nil
        anchorPoint2 = nil
        
        arView?.scene.anchors.removeAll()
        measurementButton.setTitle("0 m", for: .normal)
        measurementButton.setTitleColor(UIColor.white, for: .normal)
        
    }
    public func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        // Delegate function from ARCoachingOverlayViewDelegate protocol.
        // Activates only after AR coaching is completed i.e. we only show the UI after plane is detected
        setupUI()
    }
}
