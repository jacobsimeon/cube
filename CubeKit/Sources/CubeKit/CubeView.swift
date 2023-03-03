import SwiftUI
import UIKit
import OCCubeKit

public struct CubeView: View {
    public init() {

    }
    
    public var body: some View {
        MetalLayerView().ignoresSafeArea()
    }
}

private struct MetalLayerView: UIViewControllerRepresentable {
    typealias UIViewType = MetalLayerUIView

    func makeUIViewController(context: Context) -> some UIViewController {
        return MetalLayerViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        //
    }
}

private class MetalLayerViewController: UIViewController {
    private let demo: OCDemo
    private var displayLink: CADisplayLink? = nil

    init() {
        demo = OCDemo()

        super.init(nibName: nil, bundle: nil)

        displayLink = CADisplayLink(target: self, selector: #selector(draw))
        displayLink?.add(to: .main, forMode: .common)
        displayLink?.isPaused = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        displayLink?.invalidate()
    }

    override func loadView() {
        view = MetalLayerUIView()
        start(layer: view.layer)
    }

    func start(layer: CALayer) {
        displayLink?.isPaused = false
        demo.main(layer)
    }

    @objc func draw(_: CADisplayLink) {
        demo.run()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        demo.resize()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        demo.resize()
    }
}

private class MetalLayerUIView: UIView {
    override class var layerClass: AnyClass {
        return CAMetalLayer.self
    }
}
