//
//  LocalFileManager.swift
//  SwiftUICrypto
//
//  Created by xcz on 2022/8/8.
//

import Foundation
import SwiftUI


class LocalFileManager {

    static let instance = LocalFileManager()
    private init() {  }
    
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        
        createFolderIfNeeded(folderName: folderName)
        
        guard
        let data = image.pngData(),
        let url = getURLForImage(imageName: imageName, folderName: folderName)
        else { return }
        
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving image.image:\(imageName)  \(error)")
        }
        
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard
            let imageUrl = getURLForImage(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: imageUrl.path)
            else { return nil }
        return UIImage(contentsOfFile: imageUrl.path)
                
    }
    
    
    private func createFolderIfNeeded(folderName: String) {
        guard let folderUrl = getURLForFolder(folderName: folderName) else { return }
        if !FileManager.default.fileExists(atPath: folderUrl.path) {
            do {
                try FileManager.default.createDirectory(at: folderUrl, withIntermediateDirectories: true)
            } catch let error {
                print("Error create folder.folderName:\(folderName)  \(error)")
            }
        }
    }
    
    
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(url.path)
    }
    
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folderUrl = getURLForFolder(folderName: folderName) else {
            return nil
            
        }
        return folderUrl.appendingPathComponent(imageName + ".png")
    }
    
    
}



