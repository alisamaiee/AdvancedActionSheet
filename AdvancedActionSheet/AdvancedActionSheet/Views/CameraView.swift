//
//  CameraView.swift
//  AdvancedActionSheet
//
//  Created by Ali Samaiee on 4/7/20.
//  Copyright © 2020 Ronak Software. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

final class CameraView: UIView {

    private lazy var videoDataOutput: AVCaptureVideoDataOutput = {
        let v = AVCaptureVideoDataOutput()
        v.alwaysDiscardsLateVideoFrames = true
        v.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
        v.connection(with: .video)?.isEnabled = true
        return v
    }()

    private let videoDataOutputQueue: DispatchQueue = DispatchQueue(label: "ASVideoDataOutputQueue")
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let l = AVCaptureVideoPreviewLayer(session: session)
        l.videoGravity = .resizeAspectFill
        return l
    }()

    private let captureDevice: AVCaptureDevice? = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
    private lazy var session: AVCaptureSession = {
        let s = AVCaptureSession()
        s.sessionPreset = .vga640x480
        return s
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    private func commonInit() {
        contentMode = .scaleAspectFill
        beginSession()
    }

    private func beginSession() {
        do {
            guard let captureDevice = captureDevice else {
                debugPrint("AdvancedActionSheet: Camera doesn't work on the simulator! You have to test this on an actual device!")
                return
            }
            let deviceInput = try AVCaptureDeviceInput(device: captureDevice)
            if session.canAddInput(deviceInput) {
                session.addInput(deviceInput)
            }

            if session.canAddOutput(videoDataOutput) {
                session.addOutput(videoDataOutput)
            }
            layer.masksToBounds = true
            layer.addSublayer(previewLayer)
            previewLayer.frame = bounds
            session.startRunning()
        } catch let error {
            debugPrint("AdvancedActionSheet: \(self.self): \(#function) line: \(#line).  \(error.localizedDescription)")
        }
    }
    
    func stopSession() {
        session.stopRunning()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        previewLayer.frame = bounds
    }
}

extension CameraView: AVCaptureVideoDataOutputSampleBufferDelegate {}
