import CoreData
import UIKit
import Foundation
class coreDataHandler
{
    static let shared = coreDataHandler()
    let appdel = UIApplication.shared.delegate as! AppDelegate
    let manobj : NSManagedObjectContext?
    private init(){
        manobj = appdel.persistentContainer.viewContext
    }
    func save()
    {
        appdel.saveContext()
    }
    func insertLogin(username : String ,password : String)
    {
        let user = Login(context: manobj!)
        user.username = username
        user.password = password
        save()
    }
    func insertNote(title :String, type: String, desc : String)
    {
        let note = Notes(context: manobj!)
        note.title = title
        note.type = type
        note.desc = desc
        note.date = Date()
        save()
    }
    func update(n: Notes,title :String, type: String, desc : String)
    {
        n.title = title
        n.type = type
        n.desc = desc
        save()
    }
    func fetchNote()-> [Notes]
    {
        let fetchReq:NSFetchRequest = Notes.fetchRequest()
        do{
            return try (manobj?.fetch(fetchReq))!
        }catch{
            print("Error")
            return [Notes]()
        }
    }
    func deleteNote(n:Notes)
    {
        manobj!.delete(n)
        save()
    }
    func chklogin(username : String, password : String) -> Login
    {
        let fetchReq:NSFetchRequest = Login.fetchRequest()
        let predict = NSPredicate(format: "username contains %@ AND password contains %@",username,password)
            fetchReq.predicate = predict
        do{
            let userArr = try (manobj?.fetch(fetchReq))!
            if userArr.count == 1
            {
                return userArr[0]
            }
            else{
                return Login()
            }
        }catch{
            print("Error")
            return Login()
        }
    }
}
