//
//  CameraViewController.swift
//  2º projeto - UIcollection, AutoLayout, Câmera, Animation
//
//  Created by Bernardo Nunes on 08/07/19.
//  Copyright © 2019 Gabriel Gonçalves Guimarães. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    
    var photoOutput = AVCapturePhotoOutput()
    
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var image: UIImage?
    
    var flash: AVCaptureDevice.FlashMode = .off
    
    @IBOutlet weak var flashButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setUpPreviewLayer()
        startRunningCaptureSession()
        
    }
    
    
    
    //Terminar sessao ao sair da vc
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.captureSession.stopRunning()
    }
    
    //Ajustar qualidade das fotos
    func setupCaptureSession(){
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    //Configurar dispositivo para coletar imagem e som
    func setupDevice(){
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        
        let devices = deviceDiscoverySession.devices
        
        for device in devices{
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
        }
        
        currentCamera = backCamera
    }
    
    
    func setupInputOutput(){
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.addInput(captureDeviceInput)
            captureSession.addOutput(photoOutput)
        } catch  {
            print(error)
        }
        
    }
    
    func updateInputt(){
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.addInput(captureDeviceInput)
        } catch  {
            print(error)
        }
        
    }
    
    func setUpPreviewLayer(){
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
        
    }
    
    func startRunningCaptureSession(){
        captureSession.startRunning()
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        settings.flashMode = flash
        photoOutput.capturePhoto(with: settings, delegate: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPreview" {
            let previewVC = segue.destination as! PreviewViewController
            previewVC.image = self.image
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            image = UIImage(data: imageData)
            performSegue(withIdentifier: "showPreview", sender: nil)
        }
    }
    
    @IBAction func flashButton(_ sender: UIButton) {
       
            if flash == .off {
                flash = .on
                sender.isSelected = true
                sender.isHighlighted = false
            } else if flash == .on {
                flash = .auto
                sender.isSelected = false
                sender.isHighlighted = true
            } else {
                flash = .off
                sender.isSelected = false
                sender.isHighlighted = false
            }
            
       
    }
    
    @IBAction func toggleCameraButton(_ sender: UIButton) {
        if let inputs = captureSession.inputs as? [AVCaptureDeviceInput] {
            for input in inputs{
                captureSession.removeInput(input)
            }
        }
        
        if currentCamera == backCamera {
            currentCamera = frontCamera
            sender.isSelected = true
        } else {
            currentCamera = backCamera
            sender.isSelected = false
        }
        
        updateInputt()
    }
}
