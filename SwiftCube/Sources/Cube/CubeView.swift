import SwiftUI
import OCCube

public struct CubeView: View {
    private let demo: Demo

    init() {
        demo = Demo()
    }

    public var body: some View {
        MetalLayerView()
    }
}

private struct MetalLayerView: UIViewRepresentable {
    typealias UIViewType = MetalLayerUIView

    func makeUIView(context: Context) -> UIViewType {
        MetalLayerUIView()
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {

    }
}

private class MetalLayerUIView: UIView {
    override class var layerClass: AnyClass {
        return CAMetalLayer.self
    }
}
