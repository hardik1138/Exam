import UIKit

class AddNoteVC: UIViewController {
    
    var note : Notes?
    let txttitle:UITextField = {
        let txt = UITextField()
        txt.placeholder = "Enter title.."
        txt.layer.borderWidth = 1.0
        txt.layer.borderColor = UIColor.black.cgColor
        txt.layer.cornerRadius = 10
        return txt
    }()
    let txtdesc:UITextView = {
        let txt = UITextView()
        txt.layer.borderWidth = 1
        txt.layer.borderColor = UIColor.black.cgColor
        return txt
    }()
    let pickerView = UIPickerView()
    let Notetypedata = ["Home","Job","School","Bs"]
    let btnAdd:UIButton = {
        let btn = UIButton()
        btn.setTitle("Add", for: .normal)
        btn.addTarget(self, action: #selector(btnTapHandle), for: .touchUpInside)
        btn.backgroundColor = .systemGreen
        return btn
    }()
    @objc func btnTapHandle(){
        var type : String = ""
        type = Notetypedata[pickerView.selectedRow(inComponent: 0)]
        if let n = note
        {
            coreDataHandler.shared.update(n: n, title: txttitle.text!, type: type, desc: txtdesc.text!)
        }else{
            coreDataHandler.shared.insertNote(title: txttitle.text!, type: type, desc: txtdesc.text!)
        }
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(txttitle)
        view.addSubview(txtdesc)
        view.addSubview(pickerView)
        view.addSubview(btnAdd)
        pickerView.delegate = self
        pickerView.dataSource = self
        
        if let n = note{
            txttitle.text = n.title
            
            for i in 0...Notetypedata.count-1
            {
                if( n.type == Notetypedata[i])
                {
                    pickerView.selectRow(i, inComponent: 0, animated: true)
                }
            }
            txtdesc.text = n.desc
        }
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        txttitle.frame = CGRect(x: 10, y: 100, width: view.width - 20, height: 50)
        pickerView.frame = CGRect(x: 10, y: txttitle.bottom + 20, width: view.width - 20, height: 50)
        txtdesc.frame = CGRect(x: 10, y: pickerView.bottom + 20 , width: view.width - 20, height: 200)
        btnAdd.frame = CGRect(x: 10, y: txtdesc.bottom + 20 , width: view.width - 20, height: 50)
        
    }
}
extension AddNoteVC : UIPickerViewDelegate , UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Notetypedata.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Notetypedata[row]
    }
}
