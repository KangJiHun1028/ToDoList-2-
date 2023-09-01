import UIKit

class CompletedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var completedTasks = [Task]() // completedTasks 배열 선언 및 초기화
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self

        tableView.delegate = self
        
        // 기타 설정 및 초기화 코드...
        loadTasks()
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // 단일 섹션 반환 (완료된 작업만 표시할 것이므로)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completedTasks.count // 완료된 작업의 개수 반환 (행 수)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "completedCell", for: indexPath)
        
        let task = completedTasks[indexPath.row]
        cell.textLabel?.text = task.title
        
        return cell
    }
    
    func loadTasks() {
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "tasks") as? [[String: Any]] else { return }
        completedTasks = data.compactMap {
            guard let title = $0["title"] as? String else { return nil }
            guard let done = $0["done"] as? Bool else { return nil }
            return Task(title: title, done: done)
            
        }.filter { $0.done }
        debugPrint(completedTasks)
    }
}
