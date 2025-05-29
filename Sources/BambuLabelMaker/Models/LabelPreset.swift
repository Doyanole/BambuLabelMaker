import Foundation
import RealmSwift

class LabelPreset: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var name: String = ""
    @Persisted var filamentBrand: String = ""
    @Persisted var filamentType: String = ""
    @Persisted var color: String = ""
    @Persisted var temperature: Int = 200
    @Persisted var bedTemperature: Int = 60
    @Persisted var weight: Double = 1.0
    @Persisted var dateCreated: Date = Date()
    @Persisted var lastModified: Date = Date()
    
    convenience init(name: String, filamentBrand: String, filamentType: String, color: String, 
                    temperature: Int, bedTemperature: Int, weight: Double) {
        self.init()
        self.name = name
        self.filamentBrand = filamentBrand
        self.filamentType = filamentType
        self.color = color
        self.temperature = temperature
        self.bedTemperature = bedTemperature
        self.weight = weight
    }
} 