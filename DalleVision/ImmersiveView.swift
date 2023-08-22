//
//  ImmersiveView.swift
//  DalleVision
//
//  Created by Miffy Chen on 2023-08-22.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    @State var characterEntity: Entity = {
        let headAnchor = AnchorEntity(.head)
        headAnchor.position = [0.70, -0.35, -1]
        let radians = -30 * Float.pi / 180
        ImmersiveView.rotateEntityAroundYAxis(entity: headAnchor, angle: radians)
        return headAnchor
    }()
    
    @State var planeEntity: Entity = {
        // anchor this to a wall that is vertical and has a minimum bounds of 60cm * 60cm
        let wallAnchor = AnchorEntity(.plane(.vertical, classification: .wall, minimumBounds: SIMD2<Float>(0.6, 0.6)))
        let planeMesh = MeshResource.generatePlane(width: 3.75, depth: 3, cornerRadius: 0.1)
        let material = SimpleMaterial(color: .green, isMetallic: false)
        let planeEntity = ModelEntity(mesh: planeMesh, materials: [material])
        planeEntity.name = "canvas"
        wallAnchor.addChild(planeEntity)
        return wallAnchor
    }()
    
    var body: some View {
        RealityView { content in
            do {
                let immersiveEntity = try await Entity(named: "Immersive", in: realityKitContentBundle)
                characterEntity.addChild(immersiveEntity)
                content.add(characterEntity)
                content.add(planeEntity)
            } catch {
                print("Error in RealityView's make: \(error)")
            }
        }
    }
    
    static func rotateEntityAroundYAxis(entity: Entity, angle: Float) {
        // Get the current transform of the entity
        var currentTransform = entity.transform
        
        // Create a quaternion representing a ratation around the Y-axis
        let rotation = simd_quatf(angle: angle, axis: [0, 1, 0])
        
        // Combine the rotation with the current transform
        currentTransform.rotation = rotation * currentTransform.rotation
        
        // Apply the new transform to the entity
        entity.transform = currentTransform
    }
}

#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}
