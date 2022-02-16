//
//  ContentView.swift
//  SpellingBee
//
//  Created by Russell Gordon on 2022-02-16.
//

import AVFoundation
import SwiftUI

struct ContentView: View {
    
    // MARK: Stored properties
    @State var currentItem = itemsToSpell.randomElement()!
    @State var spellingChecked = false
    @State var spellingCorrect = false
    @State var wordGiven = ""
    
    // MARK: Computed properties
    var body: some View {
        
        VStack (alignment: .center) {
            
            Image(currentItem.imageName)
                .resizable()
                .scaledToFit()
                .onTapGesture {
                    
                    // Create the word to be spoken (an utterance) and set
                    // characteristics of how the voice will sound
                    let utterance = AVSpeechUtterance(string: currentItem.word)
                    
                    // See a list of available language codes and their corresponding
                    // voice names and genders here:
                    // https://www.ikiapps.com/tips/2015/12/30/setting-voice-for-tts-in-ios
                    utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
                    
                    // How fast the utterance will be spoken
                    utterance.rate = 0.5
                    
                    // Synthesize (speak) the utterance
                    let synthesizer = AVSpeechSynthesizer()
                    synthesizer.speak(utterance)
                    
                }
            
            HStack {
            
            TextField("Text Here", text: $wordGiven)
                .padding()
                .font(.title)
                
                Spacer()
                
                ZStack {
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(.green)
                    //        CONDITION      true  false
                        .opacity(spellingCorrect == true ? 1.0 : 0.0)
                             
                    Image(systemName: "x.square")
                        .foregroundColor(.red)
                    //        CONDITION1         AND     CONDITION2         true  false
                    //       answerChecked = true     answerCorrect = false
                        .opacity(spellingChecked == true && spellingCorrect == false ? 1.0 : 0.0)
                    }
                .padding()
                }
                
                    Button(action: {
                        
                        spellingChecked = true
                        
                        if wordGiven.lowercased() == currentItem.word{
                            spellingCorrect = true
                        } else {
                            spellingCorrect = false
                        }
                        
                    }, label: {
                        Text("Check Spelling")
            })
                .padding()
                .buttonStyle(.bordered)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
