//
//  ViewController.swift
//  SMSSDKSwiftDemo
//
//  Created by youzu_Max on 2017/8/8.
//  Copyright © 2017年 youzu. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    var phone : String!
    var area : String!
    
    weak var zoneTextField : UITextField!
    weak var phoneTextField : UITextField!
    weak var codeTextField : UITextField!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "SMSSDK swift"
        self.configUI()
    }
    
    func configUI()
    {
        self.view.backgroundColor = UIColor.white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title:SMSSDK.version(), style: UIBarButtonItemStyle.plain, target: nil, action: nil)

        let subjects = ["区号：","手机号：","验证码："]
        let places = ["请填写区号","请填写电话号码","请填写验证码"]
        
        for i in 0 ..< subjects.count{
         
            let contentView = UIView(frame: CGRect(x: 0, y: 110+50*i, width: Int(self.view.frame.size.width), height: 50))
            
            let label = UILabel()
            label.text = subjects[i]
            label.textColor = UIColor.darkGray
            label.sizeToFit()
            label.frame = CGRect(x: 100-label.frame.size.width, y: 0, width: label.frame.size.width, height: label.frame.size.height)
            contentView .addSubview(label)
            
            let textField = UITextField()
            textField.placeholder = places[i]
            textField.frame = CGRect(x: label.frame.maxX, y: label.frame.origin.y, width: 200, height: label.frame.size.height)
            contentView.addSubview(textField)
            
            let line = UIView(frame: CGRect(x: textField.frame.origin.x, y: textField.frame.maxY, width: textField.frame.size.width, height: 1.0))
            line.alpha = 0.15
            line.backgroundColor = UIColor.darkGray
            contentView.addSubview(line)
            
            switch i
            {
                case 0:
                    self.zoneTextField = textField
                    textField.text = "86"
                case 1:
                    self.phoneTextField = textField
                case 2:
                    self.codeTextField = textField
                default: break
            }
            
            self.view.addSubview(contentView)
        }
        
        let buttons = ["获取短信验证码","获取语音验证码","提交验证码","上传用户信息","获取通讯录好友"]
        
        for i in 0 ..< buttons.count
        {
            let button = UIButton(type: .system)
            button.frame = CGRect(x: self.view.frame.size.width/2 - 100, y: 275 + CGFloat(i)*66, width: 200, height: 40)
            button.setTitle(buttons[i], for: .normal)
            button.setTitleColor(UIColor.darkGray, for: .normal)
            button.setBackgroundImage(UIImage(named: "background"), for: .normal)
            self.view .addSubview(button)
            
            switch i
            {
                case 0:
                    button.addTarget(self, action: #selector(self.getTextCode), for: .touchUpInside)
                case 1:
                    button.addTarget(self, action: #selector(self.getVoiceCode), for: .touchUpInside)
                case 2:
                    button.addTarget(self, action: #selector(self.submitCode), for: .touchUpInside)
                case 3:
                    button.addTarget(self, action: #selector(self.submitUser), for: .touchUpInside)
                case 4:
                    button.addTarget(self, action: #selector(self.getFriends), for: .touchUpInside)
                default:
                    break
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

// MARK: - Click Event
extension ViewController
{
    func enableContactFriends(_ sender:Any?) -> Void
    {
        if let switcher = sender as? UIButton {
        
            switcher.isSelected = !switcher.isSelected
            
            if switcher.isSelected
            {
                SMSSDK.enableAppContactFriends(true)
            }
            else
            {
                SMSSDK.enableAppContactFriends(false)
            }
        }
    }
    
    func getTextCode()
    {
        if let area = self.zoneTextField.text,
            let phone = self.phoneTextField.text
        {
            SMSSDK.getVerificationCode(by: SMSGetCodeMethodSMS, phoneNumber:phone , zone: area, result: { [weak self](error) in
                
                if let _ = error
                {
                    print("-------> %@",error!)
                    
                    let alert = UIAlertController(title: "获取文本短信失败", message: "\(error!)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
                }
                else
                {
                    print("-------> 获取短信验证码成功")
                    
                    let alert = UIAlertController(title: "获取文本短信成功", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
                    
                    self?.area = area
                    self?.phone = phone
                }
            })
        }
    }
    
    func getVoiceCode()
    {
        if let area = self.zoneTextField.text,
            let phone = self.phoneTextField.text
        {
            SMSSDK.getVerificationCode(by: SMSGetCodeMethodVoice, phoneNumber:phone , zone: area, result: { [weak self](error) in
                
                if let _ = error
                {
                    print("-------> %@",error!)
                    
                    let alert = UIAlertController(title: "获取语音短信失败", message: "\(error!)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
                }
                else
                {
                    print("-------> 获取语音短信成功")
                    
                    let alert = UIAlertController(title: "获取语音短信成功", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
                    
                    self?.area = area
                    self?.phone = phone
                }
            })
        }
    }
    
    func submitCode()
    {
        if let area = self.zoneTextField.text,
            let phone = self.phoneTextField.text,
            let code = self.codeTextField.text
        {
            SMSSDK.commitVerificationCode(code, phoneNumber: phone, zone: area, result: { [weak self](error) in
                
                if let _ = error
                {
                    print("-------> %@",error!)
                    
                    let alert = UIAlertController(title: "验证短信失败", message: "\(error!)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
                }
                else
                {
                    print("-------> 验证短信成功")
                    
                    let alert = UIAlertController(title: "验证短信成功", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
                    
                    self?.area = area
                    self?.phone = phone
                }
            })
        }
    }
    
    func submitUser()
    {
        let userInfo = SMSSDKUserInfo()
        userInfo.phone = self.phone
        userInfo.setZone(self.area)
        
        SMSSDK.submitUserInfo(userInfo) {[weak self](error) in
            
            if let _ = error
            {
                print("-------> %@",error!)
                
                let alert = UIAlertController(title: "用户信息提交失败", message: "\(error!)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }
            else
            {
                print("-------> 用户信息提交成功")
                
                let alert = UIAlertController(title: "用户信息提交成功", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }

        }
    }
    
    func getFriends()
    {
        SMSSDK.getAllContactFriends {[weak self] (error, contacts) in
            
            if let _ = error
            {
                print("-------> %@",error!)
                
                let alert = UIAlertController(title: "获取通讯录好友失败", message: "\(error!)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
                self?.present(alert, animated: true, completion: nil)

            }
            else
            {
                print("-------> 获取通讯录好友成功")
                
                let alert = UIAlertController(title: "获取通讯录好友成功", message: "\(String(describing: contacts))", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
                
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
}

