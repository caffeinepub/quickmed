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
    avoidIf : Text;
    consultDoctorIf : Text;
  };

  module OTCMedicine {
    public func compare(medicine1 : OTCMedicine, medicine2 : OTCMedicine) : Order.Order {
      Text.compare(medicine1.name, medicine2.name);
    };
  };

  type Severity = {
    #mild;
    #moderate;
    #severe;
  };

  type Interaction = {
    drug1 : Text;
    drug2 : Text;
    interactionType : Text;
    severity : Severity;
    explanation : Text;
  };

  let medicines = List.fromArray<OTCMedicine>([
    {
      name = "Acetaminophen";
      brandName = "Tylenol";
      symptoms = ["Pain", "Fever", "Headache", "Body Ache", "Muscle Pain", "Back Pain"];
      minAge = 0;
      pregnancySafe = ?true;
      allergyNotes = [];
      dosageInstructions = "Adults: 500-1000mg every 4-6 hours. Max 4000mg/day. Children: 10-15mg/kg every 4-6 hours.";
      safetyLevel = #safe;
      warnings = "Avoid exceeding maximum daily dose to prevent liver damage.";
      avoidIf = "Severe liver disease.";
      consultDoctorIf = "You drink more than 3 alcoholic beverages per day.";
    },
    {
      name = "Ibuprofen";
      brandName = "Advil";
      symptoms = ["Pain", "Fever", "Inflammation", "Headache", "Body Ache", "Muscle Pain", "Joint Pain", "Back Pain"];
      minAge = 6;
      pregnancySafe = ?false;
      allergyNotes = ["NSAIDs"];
      dosageInstructions = "Adults: 200-400mg every 4-6 hours. Children: 10mg/kg every 6-8 hours.";
      safetyLevel = #caution;
      warnings = "Avoid in late pregnancy due to risk of fetal complications.";
      avoidIf = "Gastric ulcer, severe kidney disease.";
      consultDoctorIf = "You have hypertension or heart problems.";
    },
    {
      name = "Aspirin";
      brandName = "Bayer Aspirin";
      symptoms = ["Pain", "Fever", "Headache", "Body Ache", "Muscle Pain", "Inflammation"];
      minAge = 12;
      pregnancySafe = ?false;
      allergyNotes = ["Salicylates", "NSAIDs"];
      dosageInstructions = "Adults: 325-650mg every 4-6 hours as needed. Max 4000mg/day.";
      safetyLevel = #caution;
      warnings = "Do not give to children under 12 due to risk of Reye's syndrome. Avoid in pregnancy.";
      avoidIf = "Children under 12, pregnancy, allergy to salicylates, stomach ulcers.";
      consultDoctorIf = "Pain lasts more than 10 days or fever more than 3 days.";
    },
    {
      name = "Naproxen";
      brandName = "Aleve";
      symptoms = ["Pain", "Body Ache", "Muscle Pain", "Joint Pain", "Back Pain", "Headache", "Fever", "Inflammation"];
      minAge = 12;
      pregnancySafe = ?false;
      allergyNotes = ["NSAIDs"];
      dosageInstructions = "Adults: 220mg every 8-12 hours. Max 660mg/day (OTC use).";
      safetyLevel = #caution;
      warnings = "Longer-acting NSAID; take with food to reduce stomach upset. Avoid in late pregnancy.";
      avoidIf = "Gastric ulcer, severe kidney disease, late pregnancy.";
      consultDoctorIf = "You have heart disease, hypertension, or kidney problems.";
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
      avoidIf = "High blood pressure, enlarged prostate.";
      consultDoctorIf = "Taking MAO inhibitors.";
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
      avoidIf = "Severe liver impairment.";
      consultDoctorIf = "Pregnant or breastfeeding.";
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
      avoidIf = "Allergy to aspirin or salicylates.";
      consultDoctorIf = "Fever, bloody stool, or persistent symptoms.";
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
      avoidIf = "Bloody diarrhea or fever.";
      consultDoctorIf = "Diarrhea lasting more than 2 days.";
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
      avoidIf = "Chronic cough related to smoking or asthma.";
      consultDoctorIf = "Cough lasts more than 7 days.";
    },
    {
      name = "Acetaminophen/Dextromethorphan/Doxylamine";
      brandName = "NyQuil";
      symptoms = ["Cold", "Flu", "Cough", "Fever", "Sinus Pressure", "Body Ache"];
      minAge = 12;
      pregnancySafe = ?false;
      allergyNotes = [];
      dosageInstructions = "Adults: 30ml every 6 hours. Max 4 doses/day.";
      safetyLevel = #caution;
      warnings = "May cause drowsiness. Avoid alcohol and driving.";
      avoidIf = "MAO inhibitors or chronic lung disease.";
      consultDoctorIf = "Persistent cough or fever.";
    },
    {
      name = "Acetaminophen/Dextromethorphan/Phenylephrine";
      brandName = "DayQuil";
      symptoms = ["Cold", "Flu", "Cough", "Fever", "Sinus Pressure", "Body Ache"];
      minAge = 12;
      pregnancySafe = ?false;
      allergyNotes = [];
      dosageInstructions = "Adults: 30ml every 4 hours. Max 6 doses/day.";
      safetyLevel = #caution;
      warnings = "May cause insomnia, dizziness, and nausea.";
      avoidIf = "High blood pressure or thyroid disorder.";
      consultDoctorIf = "Symptoms persist more than 7 days.";
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
      avoidIf = "Glaucoma, enlarged prostate, or difficulty urinating.";
      consultDoctorIf = "Chronic use or confusion develops.";
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
      avoidIf = "Hypercalcemia or kidney stones.";
      consultDoctorIf = "Heartburn persists more than 2 weeks.";
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
      warnings = "Avoid if allergic. Avoid if you have porphyria.";
      avoidIf = "Allergy to ranitidine.";
      consultDoctorIf = "Don't use if you had allergic reactions.";
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
      avoidIf = "Children under 6.";
      consultDoctorIf = "Cough persists more than 7 days.";
    },
    {
      name = "Acetaminophen/Dextromethorphan/Phenylephrine";
      brandName = "Theraflu";
      symptoms = ["Cold", "Flu", "Cough", "Fever", "Body Ache"];
      minAge = 12;
      pregnancySafe = ?false;
      allergyNotes = [];
      dosageInstructions = "Adults: 1 packet every 4 hours. Max 5 packets/day.";
      safetyLevel = #caution;
      warnings = "May cause drowsiness and dizziness.";
      avoidIf = "High blood pressure or thyroid disorder.";
      consultDoctorIf = "Symptoms persist more than 7 days.";
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
      avoidIf = "Allergy to menthol.";
      consultDoctorIf = "Cough persists more than 7 days.";
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
      avoidIf = "Allergy to H2 blockers.";
      consultDoctorIf = "Heartburn persists more than 2 weeks.";
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
      avoidIf = "Severe gastrointestinal disorders.";
      consultDoctorIf = "Bloating persists.";
    },
    {
      name = "Chloraseptic";
      brandName = "Chloraseptic";
      symptoms = ["Sore Throat"];
      minAge = 6;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Spray directly on throat every 2 hours as needed.";
      safetyLevel = #safe;
      warnings = "For short-term use only.";
      avoidIf = "Allergy to ingredients.";
      consultDoctorIf = "Sore throat lasts over 2 days.";
    },
  ]);

  let interactions = List.fromArray<Interaction>([
    {
      drug1 = "Acetaminophen";
      drug2 = "Alcohol";
      interactionType = "Drug-Food";
      severity = #severe;
      explanation = "Combining acetaminophen with alcohol increases the risk of severe liver damage.";
    },
    {
      drug1 = "Ibuprofen";
      drug2 = "Aspirin";
      interactionType = "Drug-Drug";
      severity = #moderate;
      explanation = "Taking ibuprofen and aspirin together can increase the risk of gastrointestinal bleeding.";
    },
    {
      drug1 = "Diphenhydramine";
      drug2 = "Alcohol";
      interactionType = "Drug-Food";
      severity = #severe;
      explanation = "Both diphenhydramine and alcohol are sedatives; combining them can cause severe drowsiness, confusion, and impaired coordination.";
    },
    {
      drug1 = "Aspirin";
      drug2 = "Warfarin";
      interactionType = "Drug-Drug";
      severity = #severe;
      explanation = "Aspirin can enhance the blood-thinning effects of warfarin, increasing the risk of bleeding.";
    },
    {
      drug1 = "Bismuth Subsalicylate";
      drug2 = "Warfarin";
      interactionType = "Drug-Drug";
      severity = #severe;
      explanation = "Bismuth subsalicylate contains salicylates (similar to aspirin) which can increase the blood-thinning effect of warfarin.";
    },
    {
      drug1 = "Ibuprofen";
      drug2 = "Blood Thinners";
      interactionType = "Drug-Drug";
      severity = #severe;
      explanation = "The combination increases the risk of bleeding, especially in the stomach and intestines.";
    },
    {
      drug1 = "Antacids";
      drug2 = "Certain Drugs";
      interactionType = "Drug-Drug";
      severity = #mild;
      explanation = "Antacids can impair the absorption of several medications. Take them at least 1-2 hours apart.";
    },
    {
      drug1 = "Famotidine";
      drug2 = "Ranitidine";
      interactionType = "Drug-Drug";
      severity = #moderate;
      explanation = "Using two acid reducers together can increase side effects like constipation and diarrhea.";
    },
    {
      drug1 = "Simethicone";
      drug2 = "Antacids";
      interactionType = "Drug-Drug";
      severity = #mild;
      explanation = "Simethicone does not have harmful interactions with antacids and may be combined safely.";
    },
    {
      drug1 = "Dextromethorphan";
      drug2 = "MAO Inhibitors";
      interactionType = "Drug-Drug";
      severity = #severe;
      explanation = "Combining these drugs can cause dangerous serotonin syndrome.";
    },
    {
      drug1 = "Loperamide";
      drug2 = "Antibiotics";
      interactionType = "Drug-Drug";
      severity = #moderate;
      explanation = "Antibiotics can worsen loperamide-related constipation.";
    },
    {
      drug1 = "Pseudoephedrine";
      drug2 = "MAO Inhibitors";
      interactionType = "Drug-Drug";
      severity = #severe;
      explanation = "The combination can cause dangerously high blood pressure.";
    },
    {
      drug1 = "Ranitidine";
      drug2 = "Aspirin";
      interactionType = "Drug-Drug";
      severity = #mild;
      explanation = "Ranitidine can reduce stomach irritation from aspirin, but watch for side effects.";
    },
    {
      drug1 = "Calcium Carbonate";
      drug2 = "Certain Drugs";
      interactionType = "Drug-Drug";
      severity = #mild;
      explanation = "Calcium can decrease absorption of some drugs, such as thyroid medications. Take them several hours apart.";
    },
    {
      drug1 = "Bismuth Subsalicylate";
      drug2 = "Aspirin";
      interactionType = "Drug-Drug";
      severity = #moderate;
      explanation = "Both are salicylates and can increase the risk of bleeding. Avoid using together.";
    },
    {
      drug1 = "Naproxen";
      drug2 = "Aspirin";
      interactionType = "Drug-Drug";
      severity = #moderate;
      explanation = "Taking naproxen and aspirin together increases the risk of gastrointestinal bleeding.";
    },
    {
      drug1 = "Naproxen";
      drug2 = "Ibuprofen";
      interactionType = "Drug-Drug";
      severity = #moderate;
      explanation = "Combining two NSAIDs increases the risk of stomach bleeding and kidney problems.";
    },
  ]);

  public query ({ caller = _ }) func getRecommendations(symptoms : [Text], age : Nat, pregnancyStatus : Text, allergies : [Text]) : async [OTCMedicine] {
    let results = medicines.filter(
      func(med) {
        let symptomsMatch = med.symptoms.any(
          func(symptom) {
            symptoms.any(
              func(inputSymptom) {
                Text.equal(symptom.toLower(), inputSymptom.toLower());
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

    results.toArray().sort(func(a, b) { Text.compare(a.name, b.name) });
  };

  public query ({ caller = _ }) func getAllMedicines() : async [OTCMedicine] {
    medicines.toArray().sort(func(a, b) { Text.compare(a.name, b.name) });
  };

  public query ({ caller = _ }) func getAllSymptoms() : async [Text] {
    let symptomsSet = Set.empty<Text>();

    for (med in medicines.values()) {
      for (symptom in med.symptoms.values()) {
        symptomsSet.add(symptom);
      };
    };

    symptomsSet.toArray();
  };

  public query ({ caller = _ }) func checkInteractions(drugs : [Text]) : async [Interaction] {
    let lowercasedDrugs = drugs.map(
      func(drug) {
        drug.toLower();
      }
    );

    let interactionResults = List.empty<Interaction>();

    for (inter in interactions.values()) {
      let drug1Lower = inter.drug1.toLower();
      let drug2Lower = inter.drug2.toLower();

      let drug1Match = lowercasedDrugs.any(
        func(drug) {
          Text.equal(drug, drug1Lower);
        }
      );
      let drug2Match = lowercasedDrugs.any(
        func(drug) {
          Text.equal(drug, drug2Lower);
        }
      );

      if (drug1Match and drug2Match) {
        interactionResults.add(inter);
      } else if (inter.interactionType == "Drug-Food" and drug1Match) {
        interactionResults.add(inter);
      };
    };

    interactionResults.toArray();
  };
};
