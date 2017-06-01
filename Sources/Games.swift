//
//  Projects.swift
//  NestedObjectsExample
//
//  Created by Jonathan Guthrie on 2017-05-26.
//
//

import StORM
import SQLiteStORM
import PerfectLib

// Score class
// Inherits all ORM methods from SQLiteStORM superclass
class Game: SQLiteStORM {
	var id = 0
	var name = ""
	var _scores = [Score]()


	override func to(_ this: StORMRow) {
		id      = this.data["id"] as? Int ?? 0
		name	= this.data["name"] as? String ?? ""
		_scores = getScores()
	}

	func rows() -> [Game] {
		var rows = [Game]()
		for i in 0..<self.results.rows.count {
			let row = Game()
			row.to(self.results.rows[i])
			rows.append(row)
		}
		return rows
	}

	public func getScores() -> [Score] {
		let scores = Score()
		do {
			try scores.select(whereclause: "game = :1", params: [id], orderby: ["score"])
		} catch {
			print("score get error: \(error)")
		}
		return scores.rows()
	}

	public func asDict() -> [String:Any]{
		var o = [String:Any]()
		o["id"] = id
		o["name"] = name
		var scores = [[String:Any]]()
		_scores.forEach{
			score in
			var s = [String:Any]()
			s["user"] = score.user
			s["score"] = score.score
			scores.append(s)
		}
		o["scores"] = scores
		return o
	}
}
