
import UIKit

class RegVC: UIViewController {

    private let myLabel:UILabel = {
        let label = UILabel()
        label.text="Registration"
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .white
        label.font = .boldSystemFont(ofSize: 35)
        return label
    }()
    private let myTextField1:UITextField = {
        let textFiled = UITextField()
        textFiled.textColor = .black
        textFiled.placeholder = "Username"
        textFiled.textAlignment = .left
        textFiled.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        textFiled.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        textFiled.layer.borderWidth = 1
        textFiled.layer.cornerRadius = 7
        return textFiled
    }()
    private let myTextField2:UITextField = {
        let textFiled = UITextField()
        textFiled.textColor = .black
        textFiled.placeholder = "Password"
        textFiled.textAlignment = .left
        textFiled.isSecureTextEntry = true
        textFiled.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        textFiled.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        textFiled.layer.borderWidth = 1
        textFiled.layer.cornerRadius = 7
        return textFiled
    }()
    public let myButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("Register", for: .normal)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        btn.backgroundColor = .black
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 22
        return btn
    }()
    @objc func btnClick(){
        coreDataHandler.shared.insertLogin(username: myTextField1.text!, password: myTextField2.text!)
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        view.addSubview(myLabel)
        view.addSubview(myTextField1)
        view.addSubview(myTextField2)
        view.addSubview(myButton)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myLabel.frame = CGRect(x: 0, y: 200, width: view.width, height: 50)
        myTextField1.frame = CGRect(x: 30, y: myLabel.bottom + 10, width: view.width - 60, height: 45)
        myTextField2.frame = CGRect(x: 30, y: myTextField1.bottom + 10, width: view.width - 60, height: 45)
        myButton.frame = CGRect(x: 30, y: myTextField2.bottom + 20, width: view.width - 60, height: 45)
    }
}
