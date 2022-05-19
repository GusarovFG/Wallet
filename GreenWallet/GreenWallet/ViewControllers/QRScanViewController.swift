//
//  QRScanViewController.swift
//  GreenWallet
//
//  Created by Фаддей Гусаров on 14.05.2022.
//

import UIKit
import AVFoundation

class QRScanViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var video = AVCaptureVideoPreviewLayer()
    // 1. Настроим сессию
    let session = AVCaptureSession()

    override func viewDidLoad() {
        super.viewDidLoad()
//        setupVideo()
        startRunning()
    }
    
    func setupVideo() {
        // 2. Настраиваем устройство видео
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        // 3. Настроим input
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            session.addInput(input)
        } catch {
            fatalError(error.localizedDescription)
        }
        // 4. Настроим output
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        // 5
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
    }
    
    func startRunning() {
        view.layer.addSublayer(video)
        session.startRunning()
    }
    

        

    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard metadataObjects.count > 0 else { return }
        if let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
            if object.type == AVMetadataObject.ObjectType.qr {
                let superView = self.navigationController?.presentingViewController as! PushTokensViewController
                superView.adressTextField.text = object.stringValue
                self.dismiss(animated: true)
            }
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
