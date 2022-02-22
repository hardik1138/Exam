
import UIKit

class HomeVC: UIViewController {
    var noteArry:[Notes]?
    var user:Login?
    var username :String = ""
    let MyLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "Welcome"
        lbl.textAlignment = .center
        return lbl
    }()
    private let myButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("+", for: .normal)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        btn.backgroundColor = .white
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 0
        return btn
    }()
    private let myButtonLogout:UIButton = {
        let btn = UIButton()
        btn.setTitle("Logout", for: .normal)
        btn.addTarget(self, action: #selector(btnClickLogout), for: .touchUpInside)
        btn.backgroundColor = .black
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 0
        return btn
    }()
    @objc func btnClickLogout()
    {
        UserDefaults.standard.set(nil, forKey: "username")
        chkAuth()
    }
    @objc func btnClick()
    {
        let vc = AddNoteVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    func chkAuth()
    {
        if UserDefaults.standard.string(forKey: "username") != nil{
            username = UserDefaults.standard.string(forKey: "username")!
        }else{
            let vc = LoginVC()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        noteArry = coreDataHandler.shared.fetchNote()
        noteView.reloadData()
    }
    let noteView  = UITableView()
    var viewData = ["1","2","3"]
    override func viewDidLoad() {
        chkAuth()
        view.backgroundColor = .white
        view.addSubview(MyLabel)
        view.addSubview(myButton)
        view.addSubview(myButtonLogout)
        MyLabel.text = "Welcome \(username)"
        super.viewDidLoad()
        view.addSubview(noteView)
        setupTable()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        MyLabel.frame = CGRect(x: 0, y: 50, width: view.width, height: 50)
        myButtonLogout.frame = CGRect(x: MyLabel.right - 100 , y: 60, width: 80, height: 30)
        myButton.frame = CGRect(x: view.width - 40, y: MyLabel.bottom + 20, width: 20, height: 40)
        noteView.frame = CGRect(x: 20, y: myButton.bottom + 20, width: view.width - 40, height: view.height - noteView.top - 10)
    }
}
extension HomeVC : UITableViewDelegate, UITableViewDataSource{
    func setupTable()
    {
        noteView.delegate = self
        noteView.dataSource = self
        noteView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteArry!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = noteArry![indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AddNoteVC()
        vc.note = noteArry![indexPath.row]
        vc.btnAdd.setTitle("Update", for: .normal)
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        coreDataHandler.shared.deleteNote(n: noteArry![indexPath.row])
        noteArry?.remove(at: indexPath.row)
        noteView.reloadData()
    }
}
