//
//  FountainsData.swift
//  Project Cosmopolitan
//
//  Created by Lehebel Florence on 17/11/24.
//

import CoreLocation


struct Fountain {
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct FountainCoordinates {
    static let all: [Fountain] = [
        // Municipalità 1
            Fountain(name: "Via Cesario Console", coordinate: CLLocationCoordinate2D(latitude: 40.8358, longitude: 14.2499)),
            Fountain(name: "Parco Virgiliano", coordinate: CLLocationCoordinate2D(latitude: 40.8025, longitude: 14.1941)),
            Fountain(name: "Piazza Duca d'Aosta", coordinate: CLLocationCoordinate2D(latitude: 40.8393, longitude: 14.2417)),
            Fountain(name: "Piazza Salvatore Giacomo", coordinate: CLLocationCoordinate2D(latitude: 40.8168, longitude: 14.2109)),
            Fountain(name: "Piazza San Luigi", coordinate: CLLocationCoordinate2D(latitude: 40.8061, longitude: 14.2142)),
            Fountain(name: "Rotonda Diaz", coordinate: CLLocationCoordinate2D(latitude: 40.8311, longitude: 14.2345)),
        
        // Municipalità 2
            Fountain(name: "Via Benedetto Croce 1-4", coordinate: CLLocationCoordinate2D(latitude: 40.8479, longitude: 14.2532)),
            Fountain(name: "Piazza Dante", coordinate: CLLocationCoordinate2D(latitude: 40.8492, longitude: 14.2518)),
            Fountain(name: "Piazza del Gesù", coordinate: CLLocationCoordinate2D(latitude: 40.8473, longitude: 14.2526)),
            Fountain(name: "Piazza Montesanto 21", coordinate: CLLocationCoordinate2D(latitude: 40.8456, longitude: 14.2501)),
            Fountain(name: "Piazza Municipio", coordinate: CLLocationCoordinate2D(latitude: 40.8419, longitude: 14.2525)),
            Fountain(name: "Piazzetta Nilo", coordinate: CLLocationCoordinate2D(latitude: 40.8472, longitude: 14.2562)),
            Fountain(name: "Via Oberdan", coordinate: CLLocationCoordinate2D(latitude: 40.8480, longitude: 14.2600)),
            Fountain(name: "Via Santa Brigida", coordinate: CLLocationCoordinate2D(latitude: 40.8416, longitude: 14.2523)),
            Fountain(name: "Piazza Mazzini", coordinate: CLLocationCoordinate2D(latitude: 40.8543, longitude: 14.2605)),
            Fountain(name: "Corso Umberto I 265", coordinate: CLLocationCoordinate2D(latitude: 40.8470, longitude: 14.2654)),
            Fountain(name: "Largo San Francesco", coordinate: CLLocationCoordinate2D(latitude: 40.8496, longitude: 14.2519)),

            // Municipalità 3
            Fountain(name: "Piazzetta Miracoli 5-9", coordinate: CLLocationCoordinate2D(latitude: 40.8611, longitude: 14.2528)),
            Fountain(name: "Via Edoardo Nicolardi 190", coordinate: CLLocationCoordinate2D(latitude: 40.8702, longitude: 14.2427)),
            Fountain(name: "Parco Edoardo Nicolardi", coordinate: CLLocationCoordinate2D(latitude: 40.8710, longitude: 14.2405)),
            Fountain(name: "Via Cardinale Prisco 18", coordinate: CLLocationCoordinate2D(latitude: 40.8706, longitude: 14.2384)),
            Fountain(name: "Viale Privato dei Pini 12", coordinate: CLLocationCoordinate2D(latitude: 40.8698, longitude: 14.2393)),
            Fountain(name: "Discesa Bellaria", coordinate: CLLocationCoordinate2D(latitude: 40.8691, longitude: 14.2408)),
            Fountain(name: "Via Santa Maria delle Grazie a Capodimonte", coordinate: CLLocationCoordinate2D(latitude: 40.8637, longitude: 14.2444)),
            Fountain(name: "Tondo Capodimonte 30-34", coordinate: CLLocationCoordinate2D(latitude: 40.8678, longitude: 14.2465)),
            Fountain(name: "Via San Gennaro dei Poveri", coordinate: CLLocationCoordinate2D(latitude: 40.8603, longitude: 14.2522)),
            Fountain(name: "Via Bosco di Capodimonte 72", coordinate: CLLocationCoordinate2D(latitude: 40.8600, longitude: 14.2495)),
            Fountain(name: "Vico San Gaudioso (Sanità)", coordinate: CLLocationCoordinate2D(latitude: 40.8562, longitude: 14.2501)),
            Fountain(name: "Via Vergini 32", coordinate: CLLocationCoordinate2D(latitude: 40.8574, longitude: 14.2509)),

            // Municipalità 4
            Fountain(name: "Piazza Nazionale", coordinate: CLLocationCoordinate2D(latitude: 40.8533, longitude: 14.2697)),
            Fountain(name: "Piazza Poderico", coordinate: CLLocationCoordinate2D(latitude: 40.8537, longitude: 14.2725)),
            Fountain(name: "Via Gianturco", coordinate: CLLocationCoordinate2D(latitude: 40.8471, longitude: 14.2894)),
            Fountain(name: "Largo Proprio di Arianello", coordinate: CLLocationCoordinate2D(latitude: 40.8556, longitude: 14.2784)),
            Fountain(name: "Via Nuova Poggioreale", coordinate: CLLocationCoordinate2D(latitude: 40.8600, longitude: 14.2857)),

            // Municipalità 5
            Fountain(name: "Piazzetta due Porte all’Arenella", coordinate: CLLocationCoordinate2D(latitude: 40.8527, longitude: 14.2345)),
            Fountain(name: "Parco Mascagni", coordinate: CLLocationCoordinate2D(latitude: 40.8534, longitude: 14.2290)),
            Fountain(name: "Piazza IV Giornate", coordinate: CLLocationCoordinate2D(latitude: 40.8510, longitude: 14.2295)),
            Fountain(name: "Piazza Medaglie d’Oro", coordinate: CLLocationCoordinate2D(latitude: 40.8516, longitude: 14.2288)),
            Fountain(name: "Largo Madre Teresa di Calcutta", coordinate: CLLocationCoordinate2D(latitude: 40.8555, longitude: 14.2306)),
            Fountain(name: "Piazza Francesco Muzii", coordinate: CLLocationCoordinate2D(latitude: 40.8484, longitude: 14.2324)),
            Fountain(name: "Via Giambattista Ruoppolo", coordinate: CLLocationCoordinate2D(latitude: 40.8492, longitude: 14.2289)),
            Fountain(name: "Via Scarlatti", coordinate: CLLocationCoordinate2D(latitude: 40.8487, longitude: 14.2283)),

            // Municipalità 6
            Fountain(name: "Parco De Filippo", coordinate: CLLocationCoordinate2D(latitude: 40.8493, longitude: 14.3131)),
            Fountain(name: "Piazza Aprea", coordinate: CLLocationCoordinate2D(latitude: 40.8476, longitude: 14.3173)),
            Fountain(name: "Via A.C. De Meis 66", coordinate: CLLocationCoordinate2D(latitude: 40.8454, longitude: 14.3150)),
            Fountain(name: "Via Lago Fusaro", coordinate: CLLocationCoordinate2D(latitude: 40.8497, longitude: 14.3201)),
            Fountain(name: "Via Luigi Crisconio 130", coordinate: CLLocationCoordinate2D(latitude: 40.8452, longitude: 14.3160)),
            Fountain(name: "Via Alberto Marghieri 20", coordinate: CLLocationCoordinate2D(latitude: 40.8438, longitude: 14.3120)),
            Fountain(name: "Via Bartolo Longo", coordinate: CLLocationCoordinate2D(latitude: 40.8471, longitude: 14.3183)),

            // Municipalità 7
            Fountain(name: "Piazza della Libertà", coordinate: CLLocationCoordinate2D(latitude: 40.8721, longitude: 14.2714)),
            Fountain(name: "Piazza Luigi di Nocera", coordinate: CLLocationCoordinate2D(latitude: 40.8704, longitude: 14.2740)),
            Fountain(name: "Piazza Tafuri", coordinate: CLLocationCoordinate2D(latitude: 40.8730, longitude: 14.2730)),

            // Municipalità 8
            Fountain(name: "Via Santa Maria a Cubito 648", coordinate: CLLocationCoordinate2D(latitude: 40.9052, longitude: 14.2456)),
            Fountain(name: "Via Emilio Scaglione", coordinate: CLLocationCoordinate2D(latitude: 40.9000, longitude: 14.2422)),
            Fountain(name: "Via Tirone", coordinate: CLLocationCoordinate2D(latitude: 40.9033, longitude: 14.2438)),
            Fountain(name: "Piazza Nicola Romano", coordinate: CLLocationCoordinate2D(latitude: 40.9021, longitude: 14.2450)),

            // Municipalità 9
            Fountain(name: "Via Alfredo Capelli", coordinate: CLLocationCoordinate2D(latitude: 40.8630, longitude: 14.2160)),
            Fountain(name: "Via Comunale Cannavino 6", coordinate: CLLocationCoordinate2D(latitude: 40.8625, longitude: 14.2120)),

            // Municipalità 10
            Fountain(name: "Piazza Salvemini", coordinate: CLLocationCoordinate2D(latitude: 40.8210, longitude: 14.2030)),
            Fountain(name: "Via Consalvo 101", coordinate: CLLocationCoordinate2D(latitude: 40.8208, longitude: 14.2100))
        ]
}
