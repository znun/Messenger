//
//  FileStorage.swift
//  Messenger
//
//  Created by Mahmudul Hasan on 18/3/23.
//

import Foundation
import FirebaseStorage
import ProgressHUD

let storage = Storage.storage()

class FileStorage {
    
    //MARK: - Images
    class func uploadImage(_ image: UIImage, directory: String, completion: @escaping(_ documentLink: String?) -> Void) {
        
        let storageRef = storage.reference(forURL: kFILESTORAGE).child(directory)
        
        let imageData = image.jpegData(compressionQuality: 0.6)
        
        var task: StorageUploadTask!
        
        task = storageRef.putData(imageData!, metadata: nil, completion: { (metadata, error) in
            
            task.removeAllObservers()
            ProgressHUD.dismiss()
            
            if error != nil {
                print("error uploading image \(error!.localizedDescription)")
                return
            }
            storageRef.downloadURL { (url, error) in
                
                guard let downloadUrl = url else {
                    completion(nil)
                    return
                }
                completion(downloadUrl.absoluteString)
            }
           
        })
        
        task.observe(StorageTaskStatus.progress) { (snapshot) in
            
            let progress = snapshot.progress!.completedUnitCount / snapshot.progress!.totalUnitCount
            ProgressHUD.showProgress(CGFloat(progress))
        }
    }
    
    class func downloadImage(imageUrl: String, completion: @escaping(_ image: UIImage?) -> Void) {
        
       let imageFileName = fileNameFrom(fileUrl: imageUrl)
       
        if fileExistsAtPath(path: imageUrl) {
            //get it locally
            print("we have local image")
            
            if let contentsOfFile = UIImage(contentsOfFile: fileInDocumentsDirectory(fileName: imageFileName)){
               completion(contentsOfFile)
            } else {
                print("couldn't convert local image")
                completion(UIImage(named: "avatar"))
            }
        } else {
            //download from FB
           // print("let's get from FB")
            
            if imageUrl != "" {
                let documentUrl = URL(string: imageUrl)
                
                let downloadQueue = DispatchQueue(label: "imageDownloadQueue")
                
                downloadQueue.async {
                    let data = NSData(contentsOf: documentUrl!)
                    
                    if data != nil {
                        //Save locally
                        FileStorage.saveLocally(fileData: data!, fileName: imageFileName)
                        
                        DispatchQueue.main.async {
                            completion(UIImage(data: data! as Data))
                        }
                    } else {
                        print("no document if database")
                        
                        DispatchQueue.main.async {
                            completion(nil)
                        }
                    }
                }
            }
        }
      
        print(fileNameFrom(fileUrl: imageUrl))
    }
   
    //MARK: - Video
    
    class func uploadVideo(_ video: NSData, directory: String, completion: @escaping(_ videoLink: String?) -> Void) {
        
        let storageRef = storage.reference(forURL: kFILESTORAGE).child(directory)
        
        var task: StorageUploadTask!
        
        task = storageRef.putData(video as! Data, metadata: nil, completion: { (metadata, error) in
            
            task.removeAllObservers()
            ProgressHUD.dismiss()
            
            if error != nil {
                print("error uploading video \(error!.localizedDescription)")
                return
            }
            storageRef.downloadURL { (url, error) in
                
                guard let downloadUrl = url else {
                    completion(nil)
                    return
                }
                completion(downloadUrl.absoluteString)
            }
           
        })
        
        task.observe(StorageTaskStatus.progress) { (snapshot) in
            
            let progress = snapshot.progress!.completedUnitCount / snapshot.progress!.totalUnitCount
            ProgressHUD.showProgress(CGFloat(progress))
        }
    }
    
    class func downloadVideo(videoLink: String, completion: @escaping(_ isReadyToPlay: Bool, _ videoFileName: String) -> Void) {
        
       let videoUrl = URL(string: videoLink)
       let videoFileName = fileNameFrom(fileUrl: videoLink) + ".mov"
       
        if fileExistsAtPath(path: videoFileName) {
            //get it locally
            
            completion(true, videoFileName)
            
        }  else {
           
            let downloadQueue = DispatchQueue(label: "VideoDownloadQueue")
            
            downloadQueue.async {
                
                let data = NSData(contentsOf: videoUrl!)
                
                if data != nil {
                    
                    //save locally
                    FileStorage.saveLocally(fileData: data!, fileName: videoFileName)
                    
                    DispatchQueue.main.async {
                        completion(true, videoFileName)
                    }
                } else {
                    print("No document in database")
                }
            }
        }
      
    }
    
    //MARK: - Audio
    class func uploadAudio(_ audioFileName: String, directory: String, completion: @escaping(_ audioLink: String?) -> Void) {
        
        let fileName = audioFileName + ".m4a"
        
        let storageRef = storage.reference(forURL: kFILESTORAGE).child(directory)
        
        var task: StorageUploadTask!
        
        if fileExistsAtPath(path: fileName) {
            
            if let audioData = NSData(contentsOfFile: fileInDocumentsDirectory(fileName: fileName)) {
                
                task = storageRef.putData(audioData as Data, metadata: nil, completion: {(metaData, error) in
                    
                    task.removeAllObservers()
                    ProgressHUD.dismiss()
                    
                    if error != nil {
                        print("Error sending audio ", error!.localizedDescription)
                        return
                    }
                    
                    storageRef.downloadURL { (url, error) in
                        
                        guard let downloadUrl = url else {
                            completion(nil)
                            return
                        }
                        completion(downloadUrl.absoluteString)
                    }
                })
                
                task.observe(StorageTaskStatus.progress) {(snapshot) in
                    
                    let progress = snapshot.progress!.completedUnitCount / snapshot.progress!.totalUnitCount
                    ProgressHUD.showProgress(CGFloat(progress))
                }
            } else {
                print("Nothing to upload (audio)")
            }
        }
    }
    
   
    
    //MARK: - Save Locally
    class func saveLocally(fileData: NSData, fileName: String) {
        let docUrl = getDocumentsURL().appendingPathComponent(fileName, isDirectory: false)
        fileData.write(to: docUrl, atomically: true)
    }
}

//Helpers
func fileInDocumentsDirectory(fileName: String) -> String {
    return getDocumentsURL().appendingPathComponent(fileName).path
}

func getDocumentsURL() -> URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
}

func fileExistsAtPath(path: String) -> Bool {
    
    return FileManager.default.fileExists(atPath: fileInDocumentsDirectory(fileName: path))
    
}




