import Foundation

struct ImageResponse: Codable {
    let images: Images
}

struct Images: Codable {
    let min: String
    let min3: String
    let min5: String
    let aeroplane: String
    let air: String
    let airfield: String
    let bgAnything: String
    let bgAnythingLand: String
    let bgGame: String
    let bgGameLand: String
    let bgMenu: String
    let bgMenuLand: String
    let chassis: String
    let engine: String
    let flap: String
    let fuel: String
    let illuminator: String
    let infoBtn: String
    let lane: String
    let levelBtn: String
    let loseCard: String
    let nose: String
    let pilot: String
    let plane: String
    let ramp: String
    let seat: String
    let soundOffBtn: String
    let soundOnBtn: String
    let startBtn: String
    let tail: String
    let timeBtn: String
    let volumeBtn: String
    let wheel: String
    let winCard: String
    let wing: String
}
