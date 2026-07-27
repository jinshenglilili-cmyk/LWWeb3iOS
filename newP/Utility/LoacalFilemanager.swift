//
//  LoacalFilemanager.swift
//  newP
//
//  Created by Liwei on 2026/1/4.
//

import Foundation
import UIKit
class LocalFileManager {
    static var instance = LocalFileManager()
    private init (){
        
    }
    func saveImage(image:UIImage, folderName: String, imageName: String) {
        guard let data = image.pngData(),
              let url = getURLForImage(folderName: folderName, imageName: imageName)
        else {return}
        do{
            try data.write(to: url)
        }catch{
            print("save erro \(error)")
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard let url = getURLForImage(folderName: folderName, imageName: imageName),FileManager.default.fileExists(atPath: url.path) else { return nil }
        return UIImage(contentsOfFile: url.path)
    }
    
    private func createFolderIfNeed (folderName: String){
        guard let url = self.getURLForFolder(folderName: folderName) else {
            return
        }
        if !FileManager.default.fileExists(atPath: url.path){
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)

            } catch let error {
                print("create folder erro \(folderName)")
            }
        }
    }
    
    private func getURLForFolder (folderName: String)->URL?{
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(folderName)
    }
    
    private func getURLForImage (folderName: String,imageName: String)->URL?{
        guard let folderUrl = getURLForFolder(folderName: folderName) else {
            return nil
        }
        return folderUrl.appendingPathComponent(imageName + ".png")
    }
    
}
