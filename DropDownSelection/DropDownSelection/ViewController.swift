//
//  ViewController.swift
//  DropDownSelection
//
//  Created by Mehedi Hasan on 28/11/22.
//

import UIKit


class CellClass:UITableViewCell {
    
}

class ViewController: UIViewController {
    @IBOutlet weak var buttonSelectedFruit: UIButton!
    
    @IBOutlet weak var buttonSelectedGender: UIButton!
    
    let transparentView = UIView()
    
    let tableView = UITableView()
    
    var selectedButton = UIButton()
    
    var dataSourch = [String]()
    
    let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
        
    }

    func addTransparentView(frames: CGRect) {
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView.reloadData()
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransprantView))
        transparentView.addGestureRecognizer(tapgesture)
        
        transparentView.alpha = 0
        
        UIView.animate(withDuration: 0.4, delay: 0.0,usingSpringWithDamping: 1.0,initialSpringVelocity: 1.0,options: .curveEaseOut) {
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(self.dataSourch.count * 40))
            //self.view.addSubview(tableView)
        }
    }
    
    @objc func removeTransprantView() {
        
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0,usingSpringWithDamping: 1.0,initialSpringVelocity: 1.0,options: .curveEaseOut) {
            self.transparentView.alpha = 0.0
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }
    }

    @IBAction func onClickSelectedFruit(_ sender: Any) {
        dataSourch = ["Apple","Mango","Banana","Orange"]
        selectedButton = buttonSelectedFruit
        addTransparentView(frames: buttonSelectedFruit.frame)
    }
    
    
    @IBAction func onClickSelectedGender(_ sender: Any) {
        dataSourch = ["Male","Female"]
        selectedButton = buttonSelectedGender
        addTransparentView(frames: buttonSelectedGender.frame)
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"Cell" , for: indexPath)
        cell.textLabel?.text = dataSourch[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedButton.setTitle(dataSourch[indexPath.row], for: .normal)
        removeTransprantView()
    }
    
    
}
