//
//  CameraViewController.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 18/05/22.
//

import AVFoundation
import UIKit

class CameraViewController: UIViewController {
    
    //Capture session
    var captureSession = AVCaptureSession()

    //Capture device
    var videoCaptureDevice : AVCaptureDevice?
    
    //Capture Output
    var captureOutput = AVCaptureMovieFileOutput()
    
    //Capture Preview
    var capturePreviewLayer : AVCaptureVideoPreviewLayer?
    

    // MARK: - UI Components
    private let cameraView : UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .black
        return view
    }()
}


// MARK: - LifeCycle Methods
extension CameraViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(cameraView)
        setUpCamera()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapCloseButton))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cameraView.frame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
}


// MARK: - Private Methods
private extension CameraViewController {
    
    @objc func didTapCloseButton() {
        captureSession.stopRunning()
        tabBarController?.tabBar.isHidden = false
        tabBarController?.selectedIndex = 0
    }
    
    func setUpCamera() {
        //Add Devices
        if let audioDevice = AVCaptureDevice.default(for: .audio) {
            if let audioInput = try? AVCaptureDeviceInput(device: audioDevice){
                if captureSession.canAddInput(audioInput){
                    captureSession.addInput(audioInput)
                }
            }
        }
        
        if let videoDevice = AVCaptureDevice.default(for: .video) {
            if let videoInput = try? AVCaptureDeviceInput(device: videoDevice){
                if captureSession.canAddInput(videoInput){
                    captureSession.addInput(videoInput)
                }
            }
        }
        
        //Update the session
        captureSession.sessionPreset = .hd1280x720
        if captureSession.canAddOutput(captureOutput) {
            captureSession.addOutput(captureOutput)
        }
        
        //configure preview
        capturePreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        capturePreviewLayer?.videoGravity = .resizeAspectFill
        capturePreviewLayer?.frame = view.bounds
        if let layer = capturePreviewLayer {
            cameraView.layer.addSublayer(layer)
        }
        
        //Enable camera start
        captureSession.startRunning()
    }
}


// MARK: -
extension CameraViewController : AVCaptureFileOutputRecordingDelegate {
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        
        guard error == nil else {
            return
        }
        
        print("Finished video recording to url: \(outputFileURL.absoluteURL)")
    }
}
