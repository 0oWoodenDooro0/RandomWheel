//
//  DataStore.swift
//  RandomWheel
//
//  Created by 木門 on 2025/4/26.
//
import Foundation

class DataStore {
    static let shared = DataStore()

    private let fileURL: URL

    private init() {
        guard let applicationSupportDirectory = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
            fatalError("can't find Application Support directory")
        }

        let directoryURL = applicationSupportDirectory.appendingPathComponent("WheelData")
        if !FileManager.default.fileExists(atPath: directoryURL.path) {
            do {
                try FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
            } catch {
                fatalError("can't create Application Support directory: \(error)")
            }
        }

        fileURL = directoryURL.appendingPathComponent("sectors.json")
    }

    func load() -> [Sector]? {
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            print("Data not found.")
            return nil
        }

        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let sectors = try decoder.decode([Sector].self, from: data)
            print("Load data successfully.")
            return sectors
        } catch {
            print("Failed to load data: \(error)")
            return nil
        }
    }

    func save(_ sectors: [Sector]) {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(sectors)
            try data.write(to: fileURL, options: [.atomicWrite, .completeFileProtection])
            print("Save data successfully.")
        } catch {
            print("Failed to save data: \(error)")
        }
    }
}
