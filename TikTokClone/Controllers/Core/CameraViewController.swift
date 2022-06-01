//
//  CameraViewController.swift
//  TikTokClone
//
//  Created by unthinkable-mac-0025 on 18/05/22.
//

import AVFoundation
import UIKit

class CameraViewController: UIViewController {
    
    private var recorderVideoURL : URL?
    
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
    
    private let recordButton = RecordButton()
    private var previewLayer : AVPlayerLayer?
}


// MARK: - LifeCycle Methods
extension CameraViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(cameraView)
        view.addSubview(recordButton)
        setUpCamera()
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(didTapCloseButton)
        )
        recordButton.addTarget(self, action: #selector(didTapRecordButton), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cameraView.frame = view.bounds
        let recordButtonSize : CGFloat = 80
        recordButton.frame = CGRect(
            x: (view.width - recordButtonSize)/2,
            y: view.height - view.safeAreaInsets.bottom - recordButtonSize,
            width: recordButtonSize,
            height: recordButtonSize
        )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
}


// MARK: - Private Methods
private extension CameraViewController {
    
    @objc func didTapRecordButton() {
        if captureOutput.isRecording {
            //Stop recording
            recordButton.toggle(for: .notRecording)
            captureOutput.stopRecording()
        }else{
            //Save the Video File in the documents directory
            guard var url = FileManager.default.urls(
                for: .documentDirectory,
                in: .userDomainMask
            ).first else {
                return
            }
            
            url.appendPathComponent("video.mov")
            
            recordButton.toggle(for: .recording)
            //Delete the File
            try? FileManager.default.removeItem(at: url)
            
            captureOutput.startRecording(to: url, recordingDelegate: self)
        }
    }
    
    @objc func didTapCloseButton() {
        navigationItem.rightBarButtonItem = nil
        recordButton.isHidden = false
        if previewLayer != nil {   //if the preview screen is opened
            previewLayer?.removeFromSuperlayer()
            previewLayer = nil
        }else{
            captureSession.stopRunning()
            tabBarController?.tabBar.isHidden = false
            tabBarController?.selectedIndex = 0
        }
        
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
    
    @objc func didTapNextButton() {
        
    }
}


// MARK: -
extension CameraViewController : AVCaptureFileOutputRecordingDelegate {
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        
        guard error == nil else {
            let alert = UIAlertController(
                title: "Woops",
                message: "Something went wrong while recording video",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            self.present(alert, animated: true)
            return
        }
        
        recorderVideoURL = outputFileURL
        print("Finished video recording to url: \(outputFileURL.absoluteURL)")
        
        //Add "Next" by tapping which user can to add caption for the recorded video
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Next",
            style: .done,
            target: self,
            action: #selector(didTapNextButton)
        )
        
        //Show a preview screen for the recorded video
        let player = AVPlayer(url: outputFileURL)
        previewLayer = AVPlayerLayer(player: player)
        previewLayer?.videoGravity = .resizeAspectFill
        previewLayer?.frame = cameraView.bounds
        guard let previewLayer = previewLayer else {
            return
        }
        recordButton.isHidden = true
        cameraView.layer.addSublayer(previewLayer)
        previewLayer.player?.play()
    }
}
