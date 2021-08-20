//
//  PairController.swift
//  Pairs
//
//  Created by Ben Erekson on 8/20/21.
//

import CoreData

class PersonController {
    static var shared = PersonController()
    
    var people: [Person] = []
    
    //MARK: - CRUD Functions
    func createPerson(name: String) {
        people.append(Person(name: name))
        
        saveToPresistenceStore()
    }
    
    func delete(person: Person) {
        guard let index = people.firstIndex(of: person) else { return }
        people.remove(at: index)
        
        saveToPresistenceStore()
    }
 
    //MARK: - HelperMethods
    func shuffle(){
        let temp = people.shuffled()
        people.removeAll()
        people = temp
        
        saveToPresistenceStore()
    }
    
    //MARK: - Persistance
    func createPresistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("people.json")
        return fileURL
    }
    
    func saveToPresistenceStore() {
        do {
            let data = try JSONEncoder().encode(people)
            try data.write(to: createPresistenceStore())
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
    func loadFromPresistenceStore() {
        do {
            let data = try Data(contentsOf: createPresistenceStore())
            people = try JSONDecoder().decode([Person].self, from: data)
            
        }catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
}
