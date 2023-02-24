import SwiftUI
import OCCube

struct CubeView: View {
    private let demo: Demo

    init() {
        demo = Demo()
    }

    var body: some View {
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
