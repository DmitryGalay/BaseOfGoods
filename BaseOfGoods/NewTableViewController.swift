//
//  NewTableViewController.swift
//  BaseOfGoods
//
//  Created by Dima on 3/31/21.
//  Copyright © 2021 Dima. All rights reserved.
//

import UIKit

class NewTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var canselButton: UIButton!
    @IBOutlet weak var ByuButton: UIButton!
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceTextField: UITextField!
    var choose = false
    
    @IBAction func saveButton(_ sender:UIBarButtonItem) {
        if nameTextField.text == "" || adressTextField.text == "" || priceTextField.text == "" {
            print("не все поля заполнены")
        } else {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.сoreData.persistentContainer.viewContext {
                let product = Product(context: context)
                product.name = nameTextField.text
                product.location = adressTextField.text
                product.price = priceTextField.text
                product.choose = choose
                if let image = imageView.image {
                    product.image = image.pngData()
                }
                do {
                    try context.save()
                    print("сохранение удалось!")
                }catch let error as NSError{
                    print("Не удалось сохранить данные \(error), \(error.userInfo)")
                }
            }
            performSegue(withIdentifier: "backSegue", sender: self)
        }
    }
    
    @IBAction func toogleType(_ sender: UIButton) {
        if sender == ByuButton {
            sender.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            canselButton.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            choose = true
        } else {
            sender.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            ByuButton.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            choose = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ByuButton.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        canselButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let alertController = UIAlertController(title: "Добавить фото", message: nil, preferredStyle: .actionSheet)
            let cameraAction = UIAlertAction(title: "Камера", style: .default, handler: {(action) in
                self.chooseImage(source: .camera)
            })
            let photoLibAction = UIAlertAction(title: "Библиотека", style: .default, handler: {(action) in
                self.chooseImage(source: .photoLibrary)
            })
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            alertController.addAction(photoLibAction)
            alertController.addAction(cameraAction)
            alertController.addAction(cancelAction)
            self.present(alertController,animated: true ,completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func chooseImage(source: UIImagePickerController.SourceType ) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            self.present(imagePicker,animated: true,completion: nil)
        }
    }
}
