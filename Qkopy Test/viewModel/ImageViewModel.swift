//
//  ImageViewModel.swift
//  Qkopy Test
//
//  Created by user on 26/06/20.
//  Copyright © 2020 user. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol imageData {
    func imageData()
}

class ImageViewModel {
    var DataModel : ImageModel!
    var imageCount : Int = 0
    var linkBack: [String] = [String]()
    var imgArray : [String] = [String]()
    var nameArray : [String] = [String]()
    var titleArray : [String] = [String]()
    var imgDelegate : imageData!
    var fromResponse : Bool = Bool ()
    
    func getimages()  {
        var semaphore = DispatchSemaphore (value: 0)
        var request = URLRequest(url: URL(string: "https://api.imgur.com/3/account/almaloca/images")!,timeoutInterval: Double.infinity)
        request.addValue("Bearer Client-ID fa6c8e6b5fefdce", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("IMGURUIDJAFO=fc8181b58c4fc5021cdf050564981d7e46808cb7b52387afcc7a249611039059; _ga=GA1.2.41945679.1593115211; _gid=GA1.2.1913376491.1593115211; __auc=ccca08b6172ed10f44398d623c3; _fbp=fb.1.1593115211021.593369128; __qca=P0-1243730076-1593115211097; accesstoken=794c245390203712053d089ec2d64cfd130624ed; is_authed=1; amplitude_id_f1fc2abcb6d136bd4ef338e7fc0b9d05imgur.com=eyJkZXZpY2VJZCI6IjA0MDZmNWFlLWM0MWEtNDljOC1iZGJkLWM3MTM0MGZjODJiMVIiLCJ1c2VySWQiOiIxMzM1MzkyMzkiLCJvcHRPdXQiOmZhbHNlLCJzZXNzaW9uSWQiOjE1OTMxMTUyMTA1NzUsImxhc3RFdmVudFRpbWUiOjE1OTMxMTUzNTI2MzQsImV2ZW50SWQiOjAsImlkZW50aWZ5SWQiOjYsInNlcXVlbmNlTnVtYmVyIjo2fQ==; SESSIONDATA=%7B%22sessionCount%22%3A1%2C%22sessionTime%22%3A1593115352683%7D", forHTTPHeaderField: "Cookie")
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            if(statusCode == 200) {
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    print(jsonResponse)
                    if jsonResponse == nil{
                        self.fromResponse = false
                    }else{
                        self.fromResponse = false
                    }
                    guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonResponse) else { return  }
                    let resultData = try! JSONDecoder().decode(ImageModel.self, from: jsonData)
                    self.DataModel = resultData
                    self.configureimageData()
                }
                catch let error {
                    print(error)
                }
            }
        }
        task.resume()
    }
    private func configureimageData() {
        var sampleArray = ["blaaa","blaaaaaaa","blaa"]
        imageCount = (DataModel.data?.count)!
        for index in 0..<imageCount {
            imgArray.append((DataModel.data?[index].link)!)
            nameArray.append((DataModel.data?[index].name)!)
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Image", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        let imgAsArray: String = imgArray.description
        newUser.setValue(imgAsArray, forKey: "link")
        let nameAsArray: String = nameArray.description
        newUser.setValue(nameAsArray, forKey: "name")
        let arrayAsString: String = sampleArray.description
        newUser.setValue(arrayAsString, forKey: "arrayEr")
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Image")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                var arrayString = data.value(forKey: "arrayEr") as! String
                let stringAsData = arrayString.data(using: String.Encoding.utf16)
                let arrayBack: [String] = try! JSONDecoder().decode([String].self, from: stringAsData!)
                print(arrayBack[1])
                var linkString = data.value(forKey: "link") as! String
                let linkAsData = linkString.data(using: String.Encoding.utf16)
                linkBack = try! JSONDecoder().decode([String].self, from: linkAsData!)
            }
        } catch {
            print("Failed")
        }
        imgDelegate.imageData()
    }
}
