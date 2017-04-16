//
//  ChallengeViewController.swift
//  LinkBase2
//
//  Created by Michael Leung on 4/10/17.
//  Copyright © 2017 Barbara Ristau. All rights reserved.
//

import UIKit
import AVFoundation

class ChallengeViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {

	var questionIndex: Int = -1
	var questions: [Question] = []
	var company: Company?
	var currentQuestion: Question?
	var limitTimer: Timer?
	var recording = false
	
	var recordingSession: AVAudioSession!
	var audioRecorder: AVAudioRecorder!
	var audioPlayer: AVAudioPlayer?
	var audioFileName: URL?
	
	@IBOutlet weak var questionNumberLabel: UILabel!
	@IBOutlet weak var questionTextLabel: UILabel!
	@IBOutlet weak var timeLimitLabel: UILabel!
	
	@IBOutlet weak var button1: UIButton!
	@IBOutlet weak var button2: UIButton!
	@IBOutlet weak var button3: UIButton!
	@IBOutlet weak var button4: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		questions = (company?.questions)!
		self.button1.alpha = 0
		self.button2.alpha = 0
		self.button3.alpha = 0
		self.button4.alpha = 0
		renderNextQuestion()
		
		recordingSession = AVAudioSession.sharedInstance()
		
		do {
			try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
			try recordingSession.setActive(true)
			recordingSession.requestRecordPermission() { [unowned self] allowed in
				DispatchQueue.main.async {
					if allowed {
						print("allowed to record")
					} else {
						// failed to record!
					}
				}
			}
		} catch {
			// failed to record!
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func answerQuestion(index: Int?) {
		if questionIndex == (questions.count - 1) {
			performSegue(withIdentifier: "finishChallenge", sender: nil)
			return
		}
		
	
		if index != nil && self.currentQuestion?.type == "ChoiceQuestion" {
			if index == self.currentQuestion?.correctAnswerIndex {
				print("correct")
			} else {
				print("wrong")
			}
		}
		
		
		UIView.animate(withDuration: 0.2, animations: {
			self.questionNumberLabel.alpha = 0
			self.questionTextLabel.alpha = 0
			self.timeLimitLabel.alpha = 0
			self.button1.alpha = 0
			self.button2.alpha = 0
			self.button3.alpha = 0
			self.button4.alpha = 0
		}) { (true) in
			self.renderNextQuestion()
		}
	}
	
	func renderNextQuestion() {
		UIView.animate(withDuration: 0.2, animations: {
			self.questionIndex += 1
			self.currentQuestion = self.questions[self.questionIndex]
			self.questionNumberLabel.text = "\(self.questionIndex + 1)"
			self.questionTextLabel.text = self.currentQuestion?.question
			self.button3.isEnabled = true
			
			if self.currentQuestion?.type == "ChoiceQuestion" {
				self.button1.setTitle("\((self.currentQuestion?.choices?[0])!)", for: UIControlState.normal)
				self.button2.setTitle("\((self.currentQuestion?.choices?[1])!)", for: UIControlState.normal)
				self.button3.setTitle("\((self.currentQuestion?.choices?[2])!)", for: UIControlState.normal)
				self.button4.setTitle("\((self.currentQuestion?.choices?[3])!)", for: UIControlState.normal)
				self.button1.alpha = 1
				self.button2.alpha = 1
				self.button3.alpha = 1
				self.button4.alpha = 1
			} else {
				self.timeLimitLabel.text = "\(self.currentQuestion?.limit ?? 0)"
				self.button3.setTitle("Start Recording", for: UIControlState.normal)
				
				self.timeLimitLabel.alpha = 1
				self.button1.alpha = 0
				self.button2.alpha = 0
				self.button3.alpha = 1
				self.button4.alpha = 0
			}
			
			self.questionNumberLabel.alpha = 1
			self.questionTextLabel.alpha = 1
		})
	}
	
	func finishRecording(success: Bool) {
		audioRecorder.stop()
		audioRecorder = nil
		
		if success {
			recording = false
			self.limitTimer?.invalidate()
			self.button3.setTitle("Start Recording", for: UIControlState.normal)
			
			audioRecorder?.stop()
			audioRecorder = nil
			
			playAudio()
		} else {
			
			// recording failed :(
		}
	}
	
	func recordTapped() {
		if audioRecorder == nil {
			startRecording()
		} else {
			finishRecording(success: true)
		}
	}
	
	func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
		if !flag {
			finishRecording(success: false)
		}
	}
	
	func countDown() {
		print("count \(self.timeLimitLabel.text!)")
		var timeLeft = Int(self.timeLimitLabel.text!)! - 1
		self.timeLimitLabel.text = "\(timeLeft)"
		if timeLeft == 0 {
			self.finishRecording(success: true)
		}
	}
	
	func startRecording() {
		self.limitTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
		self.button3.setTitle("Stop Recording", for: UIControlState.normal)
		audioFileName = getDocumentsDirectory().appendingPathComponent("recording.m4a")

		
		let settings = [
			AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
			AVSampleRateKey: 12000,
			AVNumberOfChannelsKey: 1,
			AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
		]
		
		do {
			recording = true;
			audioRecorder = try AVAudioRecorder(url: audioFileName!, settings: settings)
			audioRecorder.delegate = self
			audioRecorder.record()
		} catch {
			print("audio error")
		}
	}
	
	func getDocumentsDirectory() -> URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		let documentsDirectory = paths[0]
		return documentsDirectory
	}
	
	func playAudio() {
		do {
			print("attempting to play audio")
			if audioFileName != nil {
				print("play audio")
				try audioPlayer = AVAudioPlayer(contentsOf: (audioFileName)!)
				audioPlayer!.delegate = self
				audioPlayer!.prepareToPlay()
				audioPlayer!.play()
				
				button3.setTitle("Previewing", for:  UIControlState.normal)
				button3.isEnabled = false
			}
		} catch let error as NSError {
			print("AudioPlayer error: \(error.localizedDescription)")
		}
	}
	
	func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
		answerQuestion(index: nil)
	}
	
	@IBAction func select1(_ sender: Any) {
		if currentQuestion?.type == "ChoiceQuestion" {
			answerQuestion(index: 0)
		}
	}

	@IBAction func select2(_ sender: Any) {
		if currentQuestion?.type == "ChoiceQuestion" {
			answerQuestion(index: 1)
		}
	}
	
	@IBAction func select3(_ sender: Any) {
		if currentQuestion?.type == "VerbalQuestion" {
			if recording {
				self.finishRecording(success: true)
			} else {
				self.startRecording()
			}
		} else {
			answerQuestion(index: 2)
		}
	}
	
	@IBAction func select4(_ sender: Any) {
		if currentQuestion?.type == "ChoiceQuestion" {
			answerQuestion(index: 3)
		}
	}
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
