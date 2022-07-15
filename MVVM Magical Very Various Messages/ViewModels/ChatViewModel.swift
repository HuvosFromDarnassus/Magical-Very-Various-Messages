//
//  ChatViewModel.swift
//  MVVM Magical Very Various Messages
//
//  Created by Daniel Tvorun on 23.06.2022.
//

import Firebase

class ChatViewModel {
    private let db = Firestore.firestore()
    
    public var messages: Dynamic = Dynamic([Message]())
    
    public func prepareMessage(by messageBody: String) {
        if let sender = Auth.auth().currentUser?.email {
            db.collection(Constants.FB.collectionName).addDocument(data: [
                Constants.FB.senderField: sender,
                Constants.FB.bodyField: messageBody,
                Constants.FB.dateField: Date().timeIntervalSince1970
            ]) { error in
                if let e = error {
                    print("MESSAGE APPENDING ERROR: \(e.localizedDescription)")
                    return
                }
            }
        }
    }
    
    public func loadMessages() {
        db.collection(Constants.FB.collectionName)
            .order(by: Constants.FB.dateField)
            .addSnapshotListener { querySnapshot, error in
                if let e = error {
                    print("MESSAGE LOADING ERROR: \(e.localizedDescription)")
                    return
                }
                
                if let snapshotDocuments = querySnapshot?.documents {
                    self.fillMessages(using: snapshotDocuments)
                }
            }
    }
    
    private func createMessageObject(using data: [String : Any], to container: inout [Message]) {
        if let sender = data[Constants.FB.senderField] as? String, let body = data[Constants.FB.bodyField] as? String {
            container.append(Message(sender: sender, body: body))
        }
    }
    
    private func fillMessages(using documents: [QueryDocumentSnapshot]) {
        var messages: [Message] = []
        
        for doc in documents {
            createMessageObject(using: doc.data(), to: &messages)
        }
        
        self.messages.value = messages
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
