import Array "mo:core/Array";
import Set "mo:core/Set";
import List "mo:core/List";
import Text "mo:core/Text";
import Order "mo:core/Order";

actor {
  type SafetyLevel = {
    #safe;
    #caution;
    #avoid;
  };

  module SafetyLevel {
    public func compare(level1 : SafetyLevel, level2 : SafetyLevel) : Order.Order {
      switch (level1, level2) {
        case (#safe, #safe) { #equal };
        case (#safe, _) { #less };
        case (#caution, #safe) { #greater };
        case (#caution, #caution) { #equal };
        case (#caution, #avoid) { #less };
        case (#avoid, #avoid) { #equal };
        case (#avoid, _) { #greater };
      };
    };
  };

  type OTCMedicine = {
    name : Text;
    brandName : Text;
    symptoms : [Text];
    minAge : Nat;
    pregnancySafe : ?Bool;
    allergyNotes : [Text];
    dosageInstructions : Text;
    safetyLevel : SafetyLevel;
    warnings : Text;
  };

  module OTCMedicine {
    public func compare(medicine1 : OTCMedicine, medicine2 : OTCMedicine) : Order.Order {
      Text.compare(medicine1.name, medicine2.name);
    };
  };

  let medicines = List.fromArray<OTCMedicine>([
    {
      name = "Acetaminophen";
      brandName = "Tylenol";
      symptoms = ["Pain", "Fever", "Headache"];
      minAge = 0;
      pregnancySafe = ?true;
      allergyNotes = [];
      dosageInstructions = "Adults: 500-1000mg every 4-6 hours. Max 4000mg/day. Children: 10-15mg/kg every 4-6 hours.";
      safetyLevel = #safe;
      warnings = "Avoid exceeding maximum daily dose to prevent liver damage.";
    },
    {
      name = "Ibuprofen";
      brandName = "Advil";
      symptoms = ["Pain", "Fever", "Inflammation", "Headache"];
      minAge = 6;
      pregnancySafe = ?false;
      allergyNotes = ["NSAIDs"];
      dosageInstructions = "Adults: 200-400mg every 4-6 hours. Children: 10mg/kg every 6-8 hours.";
      safetyLevel = #caution;
      warnings = "Avoid in late pregnancy due to risk of fetal complications.";
    },
    {
      name = "Pseudoephedrine";
      brandName = "Sudafed";
      symptoms = ["Nasal Congestion", "Sinus Pressure"];
      minAge = 12;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Adults: 60mg every 4-6 hours. Max 240mg/day.";
      safetyLevel = #caution;
      warnings = "May increase blood pressure and cause insomnia.";
    },
    {
      name = "Loratadine";
      brandName = "Claritin";
      symptoms = ["Allergy", "Hay Fever", "Runny Nose", "Itchy Eyes"];
      minAge = 2;
      pregnancySafe = ?true;
      allergyNotes = [];
      dosageInstructions = "Adults/Children over 6: 10mg once daily.";
      safetyLevel = #safe;
      warnings = "Generally well tolerated.";
    },
    {
      name = "Bismuth Subsalicylate";
      brandName = "Pepto-Bismol";
      symptoms = ["Nausea", "Diarrhea", "Heartburn", "Stomach Upset"];
      minAge = 12;
      pregnancySafe = ?false;
      allergyNotes = ["Salicylates"];
      dosageInstructions = "Adults: 30ml or 2 tablets every 30-60 minutes. Max 8 doses/day.";
      safetyLevel = #caution;
      warnings = "Avoid in children and pregnant women due to risk of Reye's syndrome.";
    },
    {
      name = "Loperamide";
      brandName = "Imodium";
      symptoms = ["Diarrhea"];
      minAge = 6;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Adults: 4mg initially, then 2mg after each loose stool. Max 8mg/day.";
      safetyLevel = #caution;
      warnings = "May cause constipation and abdominal cramps.";
    },
    {
      name = "Dextromethorphan";
      brandName = "Robitussin";
      symptoms = ["Cough"];
      minAge = 6;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Adults: 10-20mg every 4 hours. Children: 5-10mg every 4 hours.";
      safetyLevel = #caution;
      warnings = "Do not combine with MAO inhibitors.";
    },
    {
      name = "Acetaminophen/Dextromethorphan/Doxylamine";
      brandName = "NyQuil";
      symptoms = ["Cold", "Flu", "Cough", "Fever", "Sinus Pressure"];
      minAge = 12;
      pregnancySafe = ?false;
      allergyNotes = [];
      dosageInstructions = "Adults: 30ml every 6 hours. Max 4 doses/day.";
      safetyLevel = #caution;
      warnings = "May cause drowsiness. Avoid alcohol and driving.";
    },
    {
      name = "Acetaminophen/Dextromethorphan/Phenylephrine";
      brandName = "DayQuil";
      symptoms = ["Cold", "Flu", "Cough", "Fever", "Sinus Pressure"];
      minAge = 12;
      pregnancySafe = ?false;
      allergyNotes = [];
      dosageInstructions = "Adults: 30ml every 4 hours. Max 6 doses/day.";
      safetyLevel = #caution;
      warnings = "May cause insomnia, dizziness, and nausea.";
    },
    {
      name = "Diphenhydramine";
      brandName = "Benadryl";
      symptoms = ["Allergy", "Runny Nose", "Itchy Eyes", "Cough"];
      minAge = 6;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Adults: 25-50mg every 4-6 hours. Children: 12.5-25mg every 4-6 hours.";
      safetyLevel = #caution;
      warnings = "May cause significant drowsiness and dry mouth.";
    },
    {
      name = "Calcium Carbonate";
      brandName = "Tums";
      symptoms = ["Heartburn", "Acid Indigestion"];
      minAge = 0;
      pregnancySafe = ?true;
      allergyNotes = ["Calcium"];
      dosageInstructions = "Adults: 2-4 tablets as needed. Max 15 tablets/day.";
      safetyLevel = #safe;
      warnings = "Avoid excessive use to prevent hypercalcemia.";
    },
    {
      name = "Ranitidine";
      brandName = "Zantac";
      symptoms = ["Heartburn", "Acid Reflux", "Stomach Ulcer"];
      minAge = 0;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Adults: 150mg twice daily.";
      safetyLevel = #caution;
      warnings = "Avoid if allergic. Discontinued in some regions due to safety concerns.";
    },
    {
      name = "Guaifenesin";
      brandName = "Mucinex";
      symptoms = ["Cough", "Chest Congestion"];
      minAge = 6;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Adults: 200-400mg every 4 hours. Max 2400mg/day.";
      safetyLevel = #safe;
      warnings = "Take with plenty of water for best effects.";
    },
    {
      name = "Acetaminophen/Dextromethorphan/Phenylephrine";
      brandName = "Theraflu";
      symptoms = ["Cold", "Flu", "Cough", "Fever"];
      minAge = 12;
      pregnancySafe = ?false;
      allergyNotes = [];
      dosageInstructions = "Adults: 1 packet every 4 hours. Max 5 packets/day.";
      safetyLevel = #caution;
      warnings = "May cause drowsiness and dizziness.";
    },
    {
      name = "Menthol";
      brandName = "Vicks VapoRub";
      symptoms = ["Cough", "Congestion"];
      minAge = 2;
      pregnancySafe = ?true;
      allergyNotes = ["Menthol"];
      dosageInstructions = "Apply to chest, neck, and back, 3 times per day as needed.";
      safetyLevel = #safe;
      warnings = "For external use only. Avoid eyes and mouth.";
    },
    {
      name = "Calcium Carbonate";
      brandName = "Tums";
      symptoms = ["Heartburn", "Acid Indigestion"];
      minAge = 0;
      pregnancySafe = ?true;
      allergyNotes = ["Calcium"];
      dosageInstructions = "Adults: 2-4 tablets as needed. Max 15 tablets/day.";
      safetyLevel = #safe;
      warnings = "Avoid excessive use to prevent hypercalcemia.";
    },
    {
      name = "Famotidine";
      brandName = "Pepcid";
      symptoms = ["Heartburn", "Acid Reflux"];
      minAge = 12;
      pregnancySafe = ?true;
      allergyNotes = [];
      dosageInstructions = "Adults: 10-20mg taken as needed or before meals.";
      safetyLevel = #safe;
      warnings = "Generally well tolerated.";
    },
    {
      name = "Simethicone";
      brandName = "Gas-X";
      symptoms = ["Gas", "Bloating"];
      minAge = 0;
      pregnancySafe = ?true;
      allergyNotes = [];
      dosageInstructions = "Adults: 40-125mg after meals and at bedtime as needed.";
      safetyLevel = #safe;
      warnings = "No significant side effects.";
    },
    {
      name = "Polygonum Hydropiper";
      brandName = "Chloraseptic";
      symptoms = ["Sore Throat"];
      minAge = 6;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Spray directly on throat every 2 hours as needed.";
      safetyLevel = #safe;
      warnings = "For short-term use only.";
    },
  ]);

  public query ({ caller }) func getRecommendations(symptoms : [Text], age : Nat, pregnancyStatus : Text, allergies : [Text]) : async [OTCMedicine] {
    let results = medicines.filter(
      func(med) {
        let symptomsMatch = med.symptoms.any(
          func(symptom) {
            symptoms.any(
              func(inputSymptom) {
                Text.equal(symptom, inputSymptom);
              }
            );
          }
        );

        let ageMatch = age >= med.minAge;

        let pregnancyMatch = switch (med.pregnancySafe) {
          case (?true) { pregnancyStatus == "pregnant" or pregnancyStatus == "not_pregnant" };
          case (?false) { pregnancyStatus == "not_pregnant" };
          case (null) { true };
        };

        let allergiesMatch = med.allergyNotes.all(
          func(allergy) {
            not allergies.any(
              func(inputAllergy) {
                Text.equal(allergy, inputAllergy);
              }
            );
          }
        );

        symptomsMatch and ageMatch and pregnancyMatch and allergiesMatch;
      }
    );

    results.toArray().sort();
  };

  public query ({ caller }) func getAllMedicines() : async [OTCMedicine] {
    medicines.toArray().sort();
  };

  public query ({ caller }) func getAllSymptoms() : async [Text] {
    let symptomsSet = Set.empty<Text>();

    for (med in medicines.values()) {
      for (symptom in med.symptoms.values()) {
        symptomsSet.add(symptom);
      };
    };

    symptomsSet.toArray();
  };
};
