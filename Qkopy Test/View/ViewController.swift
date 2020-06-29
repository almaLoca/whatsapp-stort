//
//  ViewController.swift
//  Qkopy Test
//
//  Created by user on 24/06/20.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,imageData {
    @IBOutlet weak var collectionView: AutoScrollingCollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    var vm = ImageViewModel()
    var imagesArray :[String] = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        if Reachability.isConnectedToNetwork(){
            vm.getimages()
        }else{
            vm.fromResponse = false
            self.collectionView .reloadData()
        }
        self.initCollectionView()
        vm.imgDelegate = self
    }
    func imageData() {
        DispatchQueue.main.async {
            self.imagesArray.append(contentsOf: self.vm.linkBack)
            self.collectionView .reloadData()
        }
    }
    
    func initCollectionView() {
        self.collectionView.scrollInterval = 2
        self.collectionViewFlowLayout.scrollDirection = .horizontal
        self.collectionViewFlowLayout.minimumInteritemSpacing = 0
        self.collectionViewFlowLayout.minimumLineSpacing = 0
        self.collectionView.startScrolling()
    }
    func imageTapped(image:UIImage){
        let newImageView = UIImageView(image: image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
}
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier: String = "CustomImageCollectionCell"
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CustomImageCollectionViewCell
        if vm.fromResponse{
            print(imagesArray[indexPath.row])
            let url = URL(string: (imagesArray[indexPath.row]))
            cell.imageView.layer.masksToBounds = true
            cell.imageView.contentMode = .scaleAspectFill
            cell.imageView.downloaded(from: url!)
            self.collectionView.startScrolling()
            return cell
        }else{
            let url = URL(string: (vm.linkBack[indexPath.row]))
            cell.imageView.contentMode = .scaleAspectFill
            cell.imageView.layer.masksToBounds = true
            cell.imageView.downloaded(from: url!)
            self.collectionView.startScrolling()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if vm.fromResponse{
            return self.imagesArray.count
        }else{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
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
                    vm.linkBack = try! JSONDecoder().decode([String].self, from: linkAsData!)
                    print(vm.linkBack)
                }
            } catch {
                print("Failed")
            }
            return vm.linkBack.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let cell = collectionView.cellForItem(at: indexPath) as! CustomImageCollectionViewCell
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageDetailViewController") as! ImageDetailViewController
        if vm.fromResponse{
            vc.link = vm.imgArray[indexPath.row]
            self.collectionView.stopScrolling()
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            vc.link = vm.linkBack[indexPath.row]
            self.collectionView.stopScrolling()
            self.navigationController?.pushViewController(vc, animated: true)}
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: self.collectionView.frame.size.width, height: self.collectionView.frame.size.height)
    }
}




