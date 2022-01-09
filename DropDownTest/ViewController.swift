//
//  ViewController.swift
//  DropDownTest
//
//  Created by 은비 on 2022/01/09.
//

import UIKit
import DropDown

class ViewController: UIViewController {

    @IBOutlet weak var dropView: UIView!
    @IBOutlet weak var tfInput: UITextField!
    @IBOutlet weak var ivIcon: UIImageView!
    @IBOutlet weak var btnSelect: UIButton!
    
    let dropdown = DropDown()
    let itemList = ["item1", "item2", "item3", "item4", "item5", "item6"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        setDropdown()
    }

    // 기본 UI
    func initUI() {
        // DropDown View의 배경
        dropView.backgroundColor = UIColor.init(hex: "#F1F1F1")
        dropView.layer.cornerRadius = 8
        
        DropDown.appearance().textColor = UIColor.black
        DropDown.appearance().selectedTextColor = UIColor.red
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().selectionBackgroundColor = UIColor.lightGray
        DropDown.appearance().setupCornerRadius(8)
        dropdown.dismissMode = .automatic
        
        tfInput.text = "선택해주세요."
        
        ivIcon.tintColor = UIColor.gray
    }
    
    func setDropdown() {
        dropdown.dataSource = itemList
        dropdown.anchorView = self.dropView
        dropdown.bottomOffset = CGPoint(x: 0, y: dropView.bounds.height)
        dropdown.selectionAction = { [weak self] (_, item) in
            self!.tfInput.text = item
            self!.ivIcon.image = UIImage.init(named: "ico_triangle_bottom")
        }
        dropdown.cancelAction = { [weak self] in
            self!.ivIcon.image = UIImage.init(named: "ico_triangle_bottom")
        }
    }

    @IBAction func dropdownClicked(_ sender: Any) {
        dropdown.show()
        self.ivIcon.image = UIImage.init(named: "ico_triangle_up")
    }
    
    
}

extension UIColor {
    convenience init?(hex: String, alpha: CGFloat = 1) {
        var chars = Array(hex.hasPrefix("#") ? hex.dropFirst() : hex[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }
        case 6: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[0...1]), nil, 16)) / 255,
                green: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                 blue: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                alpha: alpha)
    }
}
