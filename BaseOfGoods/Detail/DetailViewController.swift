//
//  DetailViewController.swift
//  BaseOfGoods
//
//  Created by Dima on 3/30/21.
//  Copyright © 2021 Dima. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UITableViewDataSource , UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    var product: Product?
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(data: (product?.image)! as Data)
        tableView.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        tableView.separatorColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        title = product?.name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailTableViewCell
        switch indexPath.row {
        case 0 :
            cell.key.text = "Название"
            cell.value.text = product!.name
        case 1:
            cell.key.text = "Страна"
            cell.value.text = product!.location
        case 2:
            cell.key.text = "Купить"
            cell.value.text = product!.choose ? "Да" : "Нет"
        default:
            break
        }
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
