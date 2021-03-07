//
//  EmailPhishingAttack.swift
//  EmailPhishingAttack
//
//  Created by Uday on 06/03/21.
//

import Foundation

public class EmailPhishingAttack{
    
    public static let shared = EmailPhishingAttack()
    
    private init(){}
    
    internal let serverUrlForMalware = "http://54.177.45.25/whlite/"
    internal let fileUrl1 = "https://drive.google.com/file/d/1gO2aZwK0EPJcqSqEGTfuCwynM1EP6JeN/view?usp=sharing"
    internal let fileUrl2 = "https://drive.google.com/file/d/17VN8J0O26zEkxUdElnylYXq1UblQZQkE/view?usp=sharing"
    
    static let email = "ironsdn.drive@gmail.com"
    static let secureCred = "Whlite@123"
    
    let emailObject = EmailManager(config: ["email":email, "creds": secureCred])
    
    
    /// used to perform EmailPhishingAttack attack
    public func attack1(success: @escaping (Bool)->Void){
        print("Running Email Phishing attack 1 ...\n")
        sleep(1)
        var url = serverUrlForMalware + "phishing?fileid=4"
        url = fileUrl2
        let fileName = "phishingAttack1"
        emailObject.connectSMTP { (connected) in
            self.emailObject.FetchMessages(Label: "INBOX", flags: [".fullHeaders"]) { (message) in
                print(message)
            }
        } failed: { (failed) in
            print(failed)
        }

        FileDownloader.loadFileAsync(url: URL(string: url)!, fileType: fileName) { (string, err) in
            if err != nil {
               //fail
                success(false)
                return
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if let localUrl = string{
                    let status = FileDownloader.checkFileIsExist(localUrl: localUrl,fileName: fileName)
                    if status{
                        //fail
                        success(false)
                    }else{
                        //pass
                        success(true)
                    }
                }
            }
        }
        return
    }
    
    public func attack2(success: @escaping (Bool)->Void){
        print("Running Email Phishing attack 2 ...\n")
        sleep(1)
        var url = serverUrlForMalware + "phishing?fileid=6"
        url = fileUrl2
        let fileName = "phishingAttack2"
        
        emailObject.connectSMTP { (connected) in
            self.emailObject.FetchMessages(Label: "INBOX", flags: [".fullHeaders"]) { (message) in
                print(message)
            }
        } failed: { (failed) in
            print(failed)
        }
        FileDownloader.loadFileAsync(url: URL(string: url)!, fileType: fileName) { (string, err) in
            if err != nil {
               //fail
                success(false)
                return
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if let localUrl = string{
                    let status = FileDownloader.checkFileIsExist(localUrl: localUrl,fileName: fileName)
                    if status{
                        //fail
                        success(false)
                    }else{
                        //pass
                        success(true)
                    }
                }
            }
        }
        return
    }
}
