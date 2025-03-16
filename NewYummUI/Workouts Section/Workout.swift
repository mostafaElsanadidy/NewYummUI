//
//  Workout.swift
//  NewYummUI
//
//  Created by mostafa elsanadidy on 16.03.25.
//

import Foundation

// Workout Model
struct Workout: Codable {
    let id: Int
    let name: String
    let category: String  // e.g., Strength, Cardio
    let duration: Int  // in minutes
    let difficulty: String  // Easy, Medium, Hard
}
