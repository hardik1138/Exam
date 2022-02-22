
import UIKit

class LoginVC: UIViewController {
    let MyLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "Login"
        lbl.font = UIFont.boldSystemFont(ofSize: 34)
        lbl.textAlignment = .center
        return lbl
    }()
    let username:UITextField = {
       let txt = UITextField()
        txt.placeholder = "Enter a username"
        txt.layer.borderWidth = 1.0
        txt.layer.borderColor = UIColor.black.cgColor
        txt.layer.cornerRadius = 10
        return txt
    }()
    let password:UITextField = {
       let txt = UITextField()
        txt.placeholder = "Enter a password"
        txt.layer.borderWidth = 1.0
        txt.isSecureTextEntry = true
        txt.layer.borderColor = UIColor.black.cgColor
        txt.layer.cornerRadius = 10
        return txt
    }()
    
    let btnLogin: UIButton = {
        let btn = UIButton()
        btn.setTitle("Login", for: .normal)
        btn.addTarget(self, action: #selector(btnTapHandle), for: .touchUpInside)
        btn.backgroundColor = .blue
        btn.tintColor = .white
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 10
        btn.layer.borderColor = UIColor.black.cgColor
        return btn
    }()
    @objc func btnTapHandle()
    {
         let u = coreDataHandler.shared.chklogin(username: username.text!, password: password.text!)
        //var uu:Login?
        if u.username != ""
        {
            UserDefaults.standard.set(u.username!, forKey: "username")
            let vc = HomeVC()
            vc.user = u
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    public let btnregBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("Create a new account? Click here!", for: .normal)
        btn.addTarget(self, action: #selector(regbtnClick), for: .touchUpInside)
        btn.backgroundColor = .white
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    @objc func regbtnClick()
    {
        let vc = RegVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        super.viewDidLoad()
        view.addSubview(MyLabel)
        view.addSubview(username)
        view.addSubview(password)
        view.addSubview(btnLogin)
        view.addSubview(btnregBtn)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        MyLabel.frame = CGRect(x: 0, y: 100, width: view.width, height: 50)
        username.frame = CGRect(x: 10, y: MyLabel.bottom + 50, width: view.width - 20, height: 40)
        password.frame = CGRect(x: 10, y: username.bottom + 20, width: username.width, height: username.height)
        btnLogin.frame = CGRect(x: 10, y: password.bottom + 20, width: username.width, height: username.height)
        btnregBtn.frame = CGRect(x: 10, y: btnLogin.bottom + 20, width: username.width, height: username.height)
    }
    
}
