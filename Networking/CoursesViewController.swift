//
//  CoursesViewController.swift
//  Networking
//
//  Created by Артур Дохно on 27.07.2022.
//

import UIKit

class CoursesViewController: UITableViewController {
    
    private var courses = [Course]()
    private var courseName: String?
    private var courseURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
    }
    
    func fetchData() {
//        let jsonUrlString = "https://swiftbook.ru//wp-content/uploads/api/api_course"
        let jsonUrlString = "https://swiftbook.ru//wp-content/uploads/api/api_courses"
//        let jsonUrlString = "https://swiftbook.ru//wp-content/uploads/api/api_website_description"
//        let jsonUrlString = "https://swiftbook.ru//wp-content/uploads/api/api_missing_or_wrong_fields"
        
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                self.courses = try decoder.decode([Course].self, from: data)
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    private func configureCell(cell: TableViewCell, for indexPath: IndexPath) {
        let course = courses[indexPath.row]
        cell.courseNameLabel.text = course.name
        
        if let numberOfLessens = course.numberOfLessons {
            cell.numberOfLabel.text = "Number of lessens: \(numberOfLessens)"
        }
        
        if let numberOfTests = course.numberOfTests {
            cell.numberOfTests.text = "Number of tests: \(numberOfTests)"
        }
        
        DispatchQueue.global().async {
            guard let image = URL(string: course.imageUrl!) else { return }
            guard let imageData = try? Data(contentsOf: image) else { return }
            
            DispatchQueue.main.async {
                cell.courseImage.image = UIImage(data: imageData)
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let webViewController = segue.destination as! WebViewController
        webViewController.selectedCourse = courseName
        
        if let url = courseURL {
            webViewController.courseURL = url
        }
    }
    
    // MARK: Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell

        configureCell(cell: cell, for: indexPath)
        
        return cell
    }
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let course = courses[indexPath.row]
        
        courseURL = course.link
        courseName = course.name
        
        performSegue(withIdentifier: "Description", sender: self)
    }
}
