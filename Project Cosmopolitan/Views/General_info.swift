//
//  General_info.swift
//  Project Cosmopolitan
//
//  Created by Lehebel Florence on 11/11/24.
//

import SwiftUI

struct General_info: View {
    @State private var arrowItems = [
        ArrowItem(title: "Hardness", detailText: "The hardness of water is due to the natural presence of calcium and magnesium in it. Total hardness represents the actual hardness and can be expressed in French degrees ‘f’ (1°f = 10 mg/l CaCO₃). Recommended values are between 15 and 50 °f. Regardless of pH and alkalinity, very hard water (>38°f) causes scale deposits in pipes, especially in heating systems, and requires a high amount of detergent for laundry washing. Conversely, soft water (<13°f) can be corrosive to metal pipes."),
        ArrowItem(title: "Fixed residue at 180°C", detailText: "The fixed residue is what remains after the complete evaporation of water at 180°C and represents the sum of both organic and inorganic substances dissolved in it. Fixed residue refers to the weight of all substances dissolved in the water, and it is expressed in mg/l or ppm (parts per million). Waters are commonly classified based on fixed residue into three categories:Oligomineral: Waters with fixed residue at 180°C up to 200 mg/l, Medium Mineral: Waters with fixed residue at 180°C between 200 and 1000 mg/l, Mineral: Waters with fixed residue at 180°C higher than 1000 mg/l.The term oligomineral refers to “low-mineral” waters. A fixed residue below 100 mg/l makes the water tasteless and unfavorable for the calcification of bones and teeth; conversely, water with a fixed residue above 500 mg/l is considered hard to “digest."),
        ArrowItem(title: "pH", detailText: "The pH is defined as the negative logarithm of the hydrogen ion concentration, and represents the measure of acidity or basicity of an aqueous solution, resulting from all present chemical equilibria. A neutral solution has a pH of 7; a basic solution has a pH > 7; an acidic solution has a pH < 7."),
        ArrowItem(title: "Nitrates", detailText: "Nitrates represent the final stage of the oxidation of protein nitrogen. An increase in their concentration in water may indicate past contamination; however, nitrates can also originate from the solubilization of rock material or the leaching of soils treated with ammonium nitrate-based fertilizers. Nitrates above 100 mg/l can reduce the hemoglobin level in the blood and cause cyanosis in infants."),
        ArrowItem(title: "Nitrites", detailText: "Nitrites represent the intermediate stage of nitrogen oxidation. It is a relatively unstable form, and therefore, its presence in groundwater, especially when accompanied by ammonium ions, clearly indicates an ongoing oxidative process. The presence of nitrites in water above 0.1 mg/l is an indicator of pollution."),
        ArrowItem(title: "Ammonium", detailText: "The presence of ammonia in aquatic environments is a result of the degradation of protein substances and is almost always associated with ongoing organic-biological pollution phenomena."),
        ArrowItem(title: "Fluoride", detailText: "Generally, fluoride levels in water are below 1.5 mg/l, but in areas rich in minerals containing fluorides, groundwater can contain up to about 10 mg/l. Fluoride levels above 1.5 mg/l can cause dental fluorosis (darkening of tooth enamel). On the other hand, since fluorides have beneficial effects in preventing dental cavities, in some areas they are artificially added to drinking water (up to 1.5 mg/l)."),
        ArrowItem(title: "Chloride", detailText: "Chlorides are very common in water samples, and their origin is quite varied. Generally, water flowing through environments composed of chloride-rich sedimentary rocks, such as rock salt deposits, or water near brackish basins or close to the sea, tends to have higher chloride levels. If a water source shows continuous fluctuations in chloride concentration, this may indicate the presence of a potential pollution source, as chlorides can also come from organic material from sewage, such as urine or feces. Chlorides can be present as dissolved salts (NaCl, MgCl₂, etc.) or result from the water treatment process through the addition of sodium hypochlorite (NaClO), which contains about 14% active chlorine, used to oxidize substances in the water by releasing oxygen. For potable water, chloride content is usually considered acceptable if it does not exceed 200 mg/l of Cl-. Levels above 200 mg/l can cause pipe corrosion and unpleasant tastes (salty flavor).")
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach($arrowItems) { $item in
                    Section(header: HStack {
                        Button(action: {
                            withAnimation {
                                item.isExpanded.toggle()
                            }
                        }) {
                            Text(item.title)
                                .font(.headline)
                                .foregroundColor(.accentColor)
                            Spacer()
                            Image(systemName: item.isExpanded ? "chevron.down.circle" : "chevron.right.circle")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }

                    }) {
                        if item.isExpanded {
                            Text(item.detailText)
                                .font(.system(size: 20))
                                .padding(.leading, 30)
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
            }
            .navigationTitle("General Information")
        }
    }
}

#Preview {
    General_info()
}
