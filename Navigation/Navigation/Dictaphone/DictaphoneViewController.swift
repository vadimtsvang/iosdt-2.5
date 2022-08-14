//
//  DictaphoneViewController.swift
//  Navigation
//
//  Created by Vadim on 05.06.2022.
//

import UIKit
import AVFoundation

class DictaphoneViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {

    private let coordinator: DictaphoneCoordinator?

    var audioRecording: AVAudioRecorder?

    var audioPlayer: AVAudioPlayer?

    var recordSession: AVAudioSession?

    var audioRecord: URL?

    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Нет доступа к микрофону"
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()

    private lazy var recordingButton: UIButton = {
        let container = AttributeContainer()
        var config = UIButton.Configuration.plain()
        config.imagePlacement = .top
        let button = UIButton(configuration: config)
        button.tintColor = .gray
        button.setImage(UIImage(systemName: "record.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40)), for: .normal)
        button.setTitle("\nRecording", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(tapRecording), for: .touchUpInside)
        return button
    }()

    private lazy var playRecordingButton: UIButton = {
        let container = AttributeContainer()
        var config = UIButton.Configuration.plain()
        config.imagePlacement = .top
        let button = UIButton(configuration: config)
        button.tintColor = .black
        button.setImage(UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40)), for: .normal)
        button.setTitle("\nPlay", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(playRecording), for: .touchUpInside)
        return button
    }()

    private lazy var stackButton: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 10
        stack.distribution = .fillProportionally
        stack.addArrangedSubview(recordingButton)
        stack.addArrangedSubview(playRecordingButton)
        return stack
    }()

    init(coordinator: DictaphoneCoordinator?) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func tapRecording() {
        if audioRecording == nil {
            recording()
            recordingButton.tintColor = .red
            recordingButton.setImage(UIImage(systemName: "record.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40)), for: .normal)
            recordingButton.setTitle("\nRecording in progress", for: .normal)
        } else {
            finishRecording(success: true)
        }
    }

    @objc private func playRecording() {
        guard let audioRecord = audioRecord else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioRecord)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {

            finishRecording(success: true)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.global().async {
            sleep(UInt32(0.2))
            DispatchQueue.main.async {
                self.checkPermission()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func loadRecordingUI() {
        view.addSubviews(stackButton)
        NSLayoutConstraint.activate([
            stackButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    private func loadFailedUI() {
        view.addSubviews(statusLabel)
        NSLayoutConstraint.activate([
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }


    /// Проверка на доступ к микрофону
    func checkPermission() {
        recordSession = AVAudioSession.sharedInstance()
        do {
            try recordSession?.setCategory(.playAndRecord, mode: .default)
            try recordSession?.setActive(true)
            recordSession?.requestRecordPermission { [unowned self] granted in
                DispatchQueue.main.async {
                    if granted {
                        print("Доступ получен")
                        self.loadRecordingUI()
                    } else {
                        print("нет доступа")
                        self.loadFailedUI()
                    }
                }
            }
            if AVAudioSession.sharedInstance().recordPermission == .denied {
                print("нет доступа")
            }

        } catch {
            print(error.localizedDescription)
        }
    }

    ///  доступ к директории
    private func getDocumentsDirectory() -> URL {
        ///  массив из дирректории
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    private func recording() {
        let audioFile = getDocumentsDirectory().appendingPathComponent("recording.mp4a")
        audioRecord = audioFile

        /// настройки записи
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            audioRecording = try AVAudioRecorder(url: audioFile, settings: settings)
            audioRecording?.delegate = self
            audioRecording?.record()

        } catch {
            finishRecording(success: false)
        }
    }

    private func finishRecording(success: Bool) {
        audioRecording?.stop()
        audioRecording = nil
        audioPlayer?.stop()

        if success {
            recordingButton.tintColor = .green
            recordingButton.setImage(UIImage(systemName: "record.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40)), for: .normal)
            recordingButton.setTitle("\nRecord completed successfully", for: .normal)
        } else {
            let alert = UIAlertController(title: "Record failed", message: "Возникла проблема с записью. Пожалуйста попробуйте снова. ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
        }
    }

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
}
