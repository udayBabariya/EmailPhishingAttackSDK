//
//  FileDownloader.swift
//  RealmDemo
//
//  Created by UdayBabariya on 13/10/20.
//  Copyright © 2020 UdayBabariya. All rights reserved.
//

import Foundation

class FileDownloader {
    
    
    public static func checkFileIsExist(localUrl: String, fileName: String)->Bool{
       print("Checking File existence of",fileName)
        guard let destinationUrl = URL(string: localUrl ) else {
            print("File local Url not exist")
            return false
        }

        if FileManager().fileExists(atPath: destinationUrl.path){
            print("\(fileName) is exists")
            return true
        }else{
            print("\(fileName) Not Found")
            return false
        }
    }

    
    public static func loadFileAsync(url: URL, fileType: String, completion: @escaping (String?, Error?) -> Void){

        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
       
        guard let destinationUrl = URL(string :documentsUrl.appendingPathComponent(url.lastPathComponent).absoluteString + fileType ) else {return}

        if FileManager().fileExists(atPath: destinationUrl.path){
//            print("File already exists [\(destinationUrl.path)]")

            do {
                try FileManager.default.removeItem(atPath: destinationUrl.path)

            }catch let error as NSError{
                print("An error took place: \(error)")
            }
            sleep(1)
        }

        let session = Foundation.URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            if error == nil{
                
                if let response = response as? HTTPURLResponse{
                    
                    if response.statusCode == 200 {
                        
                        if let data = data {
                            if let _ = try? data.write(to: destinationUrl, options: Data.WritingOptions.atomic) {
                                completion(destinationUrl.path, error)
                            } else {
                                completion(destinationUrl.path, error)
                            }
                        } else {
                            completion(destinationUrl.path, error)
                        }
                    } else {
                        print("Error in \(fileType) Download")
                        let tempError = NSError(domain:"", code:1, userInfo:[ NSLocalizedDescriptionKey: ""])
                        completion(nil, tempError)
                    }
                }
            } else {
                completion(destinationUrl.path, error)
            }
        })
        task.resume()
    }
}
