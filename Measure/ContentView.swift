//
//  ContentView.swift
//  Measure
//
//  Created by Francesca Ferrini on 15/11/23.
//


import SwiftUI
import RealityKit
import UIKit
import ARKit
//ARKit is an augmented reality framework used to create an application that uses the device's camera to
//detect and trace horizontal planes in three-dimension space

struct ContentView : View {
    var body: some View {
        ZStack{
            ARViewContainer().edgesIgnoringSafeArea(.all)
        }
    }
}


struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        
        //this code configures an augmented reality view to detect horizontal flat surfaces and starts the AR
        //session to begin tracking and displaying virtual objects in three-dimensional space.
        let arView = ARView(frame: .zero)
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        arView.session.run(config)
        
        //the coordinator is used to handle events and communicate between SwiftUI and ARKit
        // assign the ARView instance to the coordinator 
        context.coordinator.arView = arView
        
        // Configure the Coordinator to handle gestures/tap events
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap)))
        
        // Add AR coaching to guide the user in detecting a horizontal plane. Coordinator acts as the delegate
        let coachingView = ARCoachingOverlayView()
        coachingView.goal = .horizontalPlane
        coachingView.session = arView.session
        coachingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingView.delegate = context.coordinator as? any ARCoachingOverlayViewDelegate
        arView.addSubview(coachingView)
        
        
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
           Coordinator()
       }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
