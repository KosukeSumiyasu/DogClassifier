//
//  PredictionViewController.swift
//  PredictionViewController
//
//  Created by Kousuke Sumiyasu on 2021/12/15.
//

import UIKit
import CoreML
import Vision
import RxSwift
import RxCocoa

final class PredictionViewController: UIViewController, UINavigationControllerDelegate {

    // MARK: - Dependency
    typealias Dependency = Void
    @IBOutlet private weak var selecteImageButton: UIButton!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var classificationLabel: UILabel!
    @IBOutlet private weak var confidenceLabel: UILabel!
    private let disposeBag: DisposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

}

extension PredictionViewController {
    private func bind() {
        selecteImageButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.addImagePickerView()
            })
            .disposed(by: disposeBag)
    }
}

extension PredictionViewController: UIImagePickerControllerDelegate{
    func addImagePickerView() {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = .photoLibrary
        pickerController.delegate = self
        self.present(pickerController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as! UIImage? else {return}
        imageView.image = selectedImage
        prediction(image: selectedImage)
        self.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    func prediction(image: UIImage) {
        guard let ciImage = CIImage(image: image) else { return }
        let defaultConfig = MLModelConfiguration()
        guard let model = try? VNCoreMLModel(for: DogImageClassifier_1(configuration: defaultConfig).model) else { return }
        let request = VNCoreMLRequest(model: model, completionHandler: visionRequestHandler)
        let handler = VNImageRequestHandler(ciImage: ciImage)
        do {
            try handler.perform([request])
        } catch {
            fatalError("error")
        }
    }

    func visionRequestHandler(_ request: VNRequest, error: Error?) {
        guard let observations = request.results as? [VNClassificationObservation] else { return }
        guard let predictions = observations.first else { return }
        updatePredictionLabel(classification: predictions.identifier, confidence: predictions.confidencePercentageString)
    }

    func updatePredictionLabel(classification: String, confidence: String) {
        DispatchQueue.main.async {
            self.classificationLabel.text = classification
            self.confidenceLabel.text = confidence
        }
    }
}
