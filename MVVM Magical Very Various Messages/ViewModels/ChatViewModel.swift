//
//  ChatViewModel.swift
//  MVVM Magical Very Various Messages
//
//  Created by Daniel Tvorun on 23.06.2022.
//

import Firebase

class ChatViewModel: ViewModel {
    private let db = Firestore.firestore()
    
    private var messages: [Message] = []
    
    public func prepareMessage(by messageBody: String) {
        if let sender = Auth.auth().currentUser?.email {
            db.collection(Constants.FB.collectionName).addDocument(data: [
                Constants.FB.senderField: sender,
                Constants.FB.bodyField: messageBody,
                Constants.FB.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    self.status.value = ("", [], .failure)
                    print("MESSAGE APPENDING ERROR: \(e.localizedDescription)")
                    
                    return
                }
                
                self.status.value = ("", [], .success)
            }
        }
    }
    
    public func loadMessages() {
        db.collection(Constants.FB.collectionName)
            .order(by: Constants.FB.dateField)
            .addSnapshotListener { querySnapshot, error in
                if let e = error {
                    self.status.value = ("", [], .failure)
                    print("MESSAGE LOADING ERROR: \(e.localizedDescription)")
                    
                    return
                }
                
                if let snapshotDocuments = querySnapshot?.documents {
                    self.messages = []
                    
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        
                        if let sender = data[Constants.FB.senderField] as? String,
                           let body = data[Constants.FB.bodyField] as? String {
                            self.messages.append(Message(sender: sender, body: body))
                        }
                    }
                    
                    self.status.value = ("", self.messages, .success)
                }
            }
    }
    
    public func checkMessageSender(by sender: String) -> Bool {
        return sender == Auth.auth().currentUser?.email
    }
    
    public func logoutUser() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("SIGN OUT ERROR: \(signOutError.localizedDescription)")
        }
    }
}
