import Foundation
import RealmSwift
import SwiftUI

@MainActor
class LabelPresetsViewModel: ObservableObject {
    private var realm: Realm
    @Published var presets: [LabelPreset] = []
    @Published var currentPreset: LabelPreset?
    
    init() {
        do {
            realm = try Realm()
            loadPresets()
        } catch {
            fatalError("Failed to initialize Realm: \(error)")
        }
    }
    
    private func loadPresets() {
        let results = realm.objects(LabelPreset.self).sorted(byKeyPath: "dateCreated", ascending: false)
        presets = Array(results)
    }
    
    func savePreset(_ preset: LabelPreset) {
        do {
            try realm.write {
                preset.lastModified = Date()
                realm.add(preset, update: .modified)
            }
            loadPresets()
        } catch {
            print("Error saving preset: \(error)")
        }
    }
    
    func deletePreset(_ preset: LabelPreset) {
        do {
            try realm.write {
                realm.delete(preset)
            }
            loadPresets()
        } catch {
            print("Error deleting preset: \(error)")
        }
    }
    
    func createNewPreset(name: String, filamentBrand: String, filamentType: String, color: String,
                        temperature: Int, bedTemperature: Int, weight: Double) -> LabelPreset {
        let preset = LabelPreset(name: name, filamentBrand: filamentBrand, filamentType: filamentType,
                                color: color, temperature: temperature, bedTemperature: bedTemperature,
                                weight: weight)
        savePreset(preset)
        return preset
    }
    
    func updatePreset(_ preset: LabelPreset, name: String? = nil, filamentBrand: String? = nil,
                     filamentType: String? = nil, color: String? = nil, temperature: Int? = nil,
                     bedTemperature: Int? = nil, weight: Double? = nil) {
        do {
            try realm.write {
                if let name = name { preset.name = name }
                if let brand = filamentBrand { preset.filamentBrand = brand }
                if let type = filamentType { preset.filamentType = type }
                if let color = color { preset.color = color }
                if let temp = temperature { preset.temperature = temp }
                if let bedTemp = bedTemperature { preset.bedTemperature = bedTemp }
                if let weight = weight { preset.weight = weight }
                preset.lastModified = Date()
            }
            loadPresets()
        } catch {
            print("Error updating preset: \(error)")
        }
    }
} 