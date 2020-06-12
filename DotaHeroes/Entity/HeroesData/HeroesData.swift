//
//  Heroes.swift
//  DotaHeroes
//
//  Created by Benedict Lukas on 12/06/20.
//  Copyright © 2020 Benedict Lukas. All rights reserved.
//

import Foundation
import CoreData

enum HeroesDataKey: String, CodingKey {
    case heroId = "id"
    case name = "localized_name"
    case type = "attack_type"
    case attack = "base_attack_max"
    case speed = "move_speed"
    case roles
    case image = "img"
    case health = "base_health"
    case attr = "primary_attr"
}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}

@objc(HeroesData)
class HeroesData: NSManagedObject, Entity, Codable {
    @NSManaged var heroId: Double
    @NSManaged var name: String
    @NSManaged var type: String
    @NSManaged var attack: Double
    @NSManaged var speed: Double
    @NSManaged var health: Double
    @NSManaged var attr: String
    @NSManaged var image: String
    @NSManaged var roles: [String]

    static func entityName() -> String {
        return "HeroesData"
    }

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: HeroesDataKey.self)
        try container.encode(heroId, forKey: .heroId)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
        try container.encode(attack, forKey: .attack)
        try container.encode(speed, forKey: .speed)
        try container.encode(health, forKey: .health)
        try container.encode(attr, forKey: .attr)
        try container.encode(image, forKey: .image)
        try container.encode(roles, forKey: .roles)
    }

    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: HeroesData.entityName(),
                                                    in: managedObjectContext) else {
            fatalError("Failed to decode Heroes Data")
        }
        self.init(entity: entity, insertInto: managedObjectContext)
        let values = try decoder.container(keyedBy: HeroesDataKey.self)
        do {
            heroId = try values.decode(Double.self, forKey: .heroId)
            name = try values.decode(String.self, forKey: .name)
            type = try values.decode(String.self, forKey: .type)
            attr = try values.decode(String.self, forKey: .attr)
            attack = try values.decode(Double.self, forKey: .attack)
            speed = try values.decode(Double.self, forKey: .speed)
            health = try values.decode(Double.self, forKey: .health)
            image = try values.decode(String.self, forKey: .image)
            roles = try values.decode([String].self, forKey: .roles)
        } catch {
            debugPrint("Error")
        }
    }
}
