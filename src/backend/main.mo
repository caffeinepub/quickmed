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
      symptoms = ["Pain", "Fever", "Headache", "Body Ache", "Muscle Pain", "Back Pain", "Toothache", "Menstrual Cramps", "Migraine", "Sore Throat", "Earache", "Minor Injury Pain"];
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
      symptoms = ["Pain", "Fever", "Inflammation", "Headache", "Body Ache", "Muscle Pain", "Joint Pain", "Back Pain", "Toothache", "Menstrual Cramps", "Migraine", "Swelling", "Minor Injury Pain", "Arthritis Pain"];
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
      symptoms = ["Pain", "Fever", "Headache", "Body Ache", "Muscle Pain", "Inflammation", "Migraine", "Toothache"];
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
      symptoms = ["Pain", "Body Ache", "Muscle Pain", "Joint Pain", "Back Pain", "Headache", "Fever", "Inflammation", "Menstrual Cramps", "Arthritis Pain", "Swelling", "Migraine"];
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
      symptoms = ["Nasal Congestion", "Sinus Pressure", "Stuffy Nose", "Sinus Congestion", "Cold", "Flu"];
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
      symptoms = ["Allergy", "Hay Fever", "Runny Nose", "Itchy Eyes", "Sneezing", "Watery Eyes", "Seasonal Allergies", "Skin Rash", "Hives", "Nasal Congestion"];
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
      name = "Cetirizine";
      brandName = "Zyrtec";
      symptoms = ["Allergy", "Hay Fever", "Runny Nose", "Itchy Eyes", "Sneezing", "Watery Eyes", "Seasonal Allergies", "Hives", "Skin Rash", "Nasal Congestion", "Itchy Skin"];
      minAge = 2;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Adults/Children over 6: 5-10mg once daily.";
      safetyLevel = #safe;
      warnings = "May cause mild drowsiness in some people.";
      avoidIf = "Severe kidney disease.";
      consultDoctorIf = "Pregnant or breastfeeding.";
    },
    {
      name = "Fexofenadine";
      brandName = "Allegra";
      symptoms = ["Allergy", "Hay Fever", "Runny Nose", "Itchy Eyes", "Sneezing", "Seasonal Allergies", "Hives", "Watery Eyes"];
      minAge = 2;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Adults/Children over 12: 180mg once daily or 60mg twice daily.";
      safetyLevel = #safe;
      warnings = "Non-drowsy formula. Avoid with fruit juices that can reduce absorption.";
      avoidIf = "Severe kidney disease.";
      consultDoctorIf = "Pregnant or breastfeeding.";
    },
    {
      name = "Bismuth Subsalicylate";
      brandName = "Pepto-Bismol";
      symptoms = ["Nausea", "Diarrhea", "Heartburn", "Stomach Upset", "Indigestion", "Vomiting", "Stomach Cramps", "Gas"];
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
      symptoms = ["Diarrhea", "Loose Stool", "Stomach Cramps"];
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
      symptoms = ["Cough", "Dry Cough", "Chest Congestion"];
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
      symptoms = ["Cold", "Flu", "Cough", "Fever", "Sinus Pressure", "Body Ache", "Runny Nose", "Sneezing", "Sore Throat", "Insomnia"];
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
      symptoms = ["Cold", "Flu", "Cough", "Fever", "Sinus Pressure", "Body Ache", "Nasal Congestion", "Runny Nose", "Sore Throat"];
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
      symptoms = ["Allergy", "Runny Nose", "Itchy Eyes", "Cough", "Hives", "Skin Rash", "Itchy Skin", "Sneezing", "Insomnia", "Motion Sickness"];
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
      symptoms = ["Heartburn", "Acid Indigestion", "Indigestion", "Stomach Upset", "Acid Reflux"];
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
      symptoms = ["Heartburn", "Acid Reflux", "Stomach Ulcer", "Indigestion", "Acid Indigestion"];
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
      symptoms = ["Cough", "Chest Congestion", "Mucus", "Phlegm", "Productive Cough"];
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
      name = "Menthol";
      brandName = "Vicks VapoRub";
      symptoms = ["Cough", "Congestion", "Nasal Congestion", "Chest Congestion", "Cold", "Sore Muscles"];
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
      symptoms = ["Heartburn", "Acid Reflux", "Indigestion", "Acid Indigestion", "Stomach Upset"];
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
      symptoms = ["Gas", "Bloating", "Flatulence", "Stomach Cramps", "Indigestion"];
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
      name = "Benzocaine";
      brandName = "Orajel";
      symptoms = ["Toothache", "Gum Pain", "Mouth Sore", "Canker Sore", "Sore Throat", "Teething Pain"];
      minAge = 2;
      pregnancySafe = null;
      allergyNotes = ["Local anesthetics"];
      dosageInstructions = "Apply small amount directly to affected area up to 4 times daily.";
      safetyLevel = #caution;
      warnings = "Do not swallow. Use sparingly. Avoid in infants under 2 for gum use.";
      avoidIf = "Allergy to benzocaine or local anesthetics.";
      consultDoctorIf = "Toothache persists more than 2 days.";
    },
    {
      name = "Chloraseptic";
      brandName = "Chloraseptic";
      symptoms = ["Sore Throat", "Throat Pain", "Throat Irritation", "Mouth Sore"];
      minAge = 6;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Spray directly on throat every 2 hours as needed.";
      safetyLevel = #safe;
      warnings = "For short-term use only.";
      avoidIf = "Allergy to ingredients.";
      consultDoctorIf = "Sore throat lasts over 2 days.";
    },
    {
      name = "Polyethylene Glycol 3350";
      brandName = "MiraLAX";
      symptoms = ["Constipation", "Irregular Bowel Movement", "Hard Stool", "Bloating"];
      minAge = 17;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Adults: 17g (1 capful) dissolved in 4-8oz of liquid once daily.";
      safetyLevel = #safe;
      warnings = "Drink plenty of fluids. May take 1-3 days to work.";
      avoidIf = "Bowel obstruction.";
      consultDoctorIf = "No bowel movement after 7 days.";
    },
    {
      name = "Docusate Sodium";
      brandName = "Colace";
      symptoms = ["Constipation", "Hard Stool", "Straining During Bowel Movement"];
      minAge = 2;
      pregnancySafe = ?true;
      allergyNotes = [];
      dosageInstructions = "Adults: 50-300mg per day. Children: 10-40mg per day.";
      safetyLevel = #safe;
      warnings = "Stool softener only; may take 1-3 days to work.";
      avoidIf = "Abdominal pain or nausea of unknown cause.";
      consultDoctorIf = "Constipation persists more than 1 week.";
    },
    {
      name = "Doxylamine Succinate";
      brandName = "Unisom";
      symptoms = ["Insomnia", "Difficulty Sleeping", "Sleep Problems", "Restlessness"];
      minAge = 12;
      pregnancySafe = ?true;
      allergyNotes = [];
      dosageInstructions = "Adults: 25mg 30 minutes before bedtime.";
      safetyLevel = #caution;
      warnings = "May cause next-day drowsiness. Avoid alcohol and driving.";
      avoidIf = "Glaucoma, enlarged prostate.";
      consultDoctorIf = "Sleep problems persist more than 2 weeks.";
    },
    {
      name = "Melatonin";
      brandName = "Natrol";
      symptoms = ["Insomnia", "Difficulty Sleeping", "Jet Lag", "Sleep Problems"];
      minAge = 0;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Adults: 0.5-5mg 30 minutes before bedtime.";
      safetyLevel = #safe;
      warnings = "May cause drowsiness. Use the lowest effective dose.";
      avoidIf = "Autoimmune conditions.";
      consultDoctorIf = "Sleep problems persist more than 2 weeks.";
    },
    {
      name = "Dimenhydrinate";
      brandName = "Dramamine";
      symptoms = ["Motion Sickness", "Nausea", "Vomiting", "Dizziness", "Vertigo"];
      minAge = 2;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Adults: 50-100mg every 4-6 hours. Max 400mg/day.";
      safetyLevel = #caution;
      warnings = "May cause drowsiness. Avoid alcohol.";
      avoidIf = "Glaucoma, enlarged prostate.";
      consultDoctorIf = "Dizziness or nausea persists.";
    },
    {
      name = "Meclizine";
      brandName = "Bonine";
      symptoms = ["Motion Sickness", "Nausea", "Dizziness", "Vertigo"];
      minAge = 12;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Adults: 25-50mg one hour before travel. Repeat every 24 hours.";
      safetyLevel = #caution;
      warnings = "May cause drowsiness.";
      avoidIf = "Glaucoma, enlarged prostate.";
      consultDoctorIf = "Vertigo or dizziness is severe.";
    },
    {
      name = "Excedrin Migraine";
      brandName = "Excedrin";
      symptoms = ["Migraine", "Headache", "Pain", "Tension Headache"];
      minAge = 12;
      pregnancySafe = ?false;
      allergyNotes = ["Aspirin", "Caffeine", "NSAIDs"];
      dosageInstructions = "Adults: 2 tablets every 6 hours. Max 8 tablets/day.";
      safetyLevel = #caution;
      warnings = "Contains aspirin, acetaminophen, and caffeine. Avoid in pregnancy.";
      avoidIf = "Children under 12, pregnancy, allergy to aspirin.";
      consultDoctorIf = "Migraines are severe, frequent, or worsening.";
    },
    {
      name = "Hydrocortisone Cream";
      brandName = "Cortaid";
      symptoms = ["Skin Rash", "Itchy Skin", "Eczema", "Insect Bites", "Hives", "Contact Dermatitis", "Redness", "Minor Skin Irritation"];
      minAge = 2;
      pregnancySafe = null;
      allergyNotes = ["Corticosteroids"];
      dosageInstructions = "Apply thin layer to affected area 2-4 times daily.";
      safetyLevel = #caution;
      warnings = "Avoid prolonged use on face. Do not use on infected skin.";
      avoidIf = "Viral or fungal skin infections.";
      consultDoctorIf = "Rash persists more than 7 days or worsens.";
    },
    {
      name = "Clotrimazole";
      brandName = "Lotrimin";
      symptoms = ["Athlete's Foot", "Jock Itch", "Ringworm", "Fungal Infection", "Itchy Skin"];
      minAge = 2;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Apply to affected area twice daily for 4 weeks.";
      safetyLevel = #safe;
      warnings = "For external use only. Complete full course of treatment.";
      avoidIf = "Deep skin infections.";
      consultDoctorIf = "Condition does not improve after 4 weeks.";
    },
    {
      name = "Miconazole";
      brandName = "Monistat";
      symptoms = ["Yeast Infection", "Vaginal Itching", "Vaginal Discharge", "Fungal Infection", "Athlete's Foot"];
      minAge = 12;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Apply as directed on package (1-day, 3-day, or 7-day treatment).";
      safetyLevel = #caution;
      warnings = "Consult a doctor before use if you have never had a yeast infection before.";
      avoidIf = "Fever, pelvic pain, or discharge with unusual odor.";
      consultDoctorIf = "Symptoms do not improve in 3 days.";
    },
    {
      name = "Docosanol";
      brandName = "Abreva";
      symptoms = ["Cold Sore", "Fever Blister", "Lip Blister"];
      minAge = 12;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Apply to affected area 5 times daily until healed.";
      safetyLevel = #safe;
      warnings = "Start treatment at the first sign of a cold sore.";
      avoidIf = "Allergy to docosanol.";
      consultDoctorIf = "Cold sore is near eyes or does not heal within 10 days.";
    },
    {
      name = "Phenylephrine (Eye Drops)";
      brandName = "Visine";
      symptoms = ["Eye Redness", "Red Eyes", "Eye Irritation", "Bloodshot Eyes"];
      minAge = 6;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Instill 1-2 drops in affected eye(s) up to 4 times daily.";
      safetyLevel = #caution;
      warnings = "Do not use for more than 3 days as it may worsen redness.";
      avoidIf = "Narrow-angle glaucoma.";
      consultDoctorIf = "Redness does not improve after 3 days.";
    },
    {
      name = "Carboxymethylcellulose Eye Drops";
      brandName = "Refresh Tears";
      symptoms = ["Dry Eyes", "Eye Irritation", "Eye Discomfort", "Burning Eyes", "Gritty Eyes"];
      minAge = 0;
      pregnancySafe = ?true;
      allergyNotes = [];
      dosageInstructions = "Instill 1-2 drops in affected eye(s) as needed.";
      safetyLevel = #safe;
      warnings = "May temporarily blur vision. Wait 15 minutes before wearing contact lenses.";
      avoidIf = "Allergy to ingredients.";
      consultDoctorIf = "Eye pain, vision changes, or redness that worsens.";
    },
    {
      name = "Oxymetazoline";
      brandName = "Afrin";
      symptoms = ["Nasal Congestion", "Stuffy Nose", "Sinus Congestion", "Sinus Pressure"];
      minAge = 6;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Adults/Children over 6: 2-3 sprays per nostril every 10-12 hours. Max 2 doses/day.";
      safetyLevel = #caution;
      warnings = "Do not use for more than 3 consecutive days. Rebound congestion may occur.";
      avoidIf = "High blood pressure, heart disease.";
      consultDoctorIf = "Taking antidepressants or MAO inhibitors.";
    },
    {
      name = "Zinc Pyrithione Shampoo";
      brandName = "Head & Shoulders";
      symptoms = ["Dandruff", "Flaky Scalp", "Itchy Scalp", "Seborrheic Dermatitis"];
      minAge = 2;
      pregnancySafe = ?true;
      allergyNotes = [];
      dosageInstructions = "Use in place of regular shampoo. Lather, leave 1-2 minutes, rinse.";
      safetyLevel = #safe;
      warnings = "For external use only.";
      avoidIf = "Allergy to zinc compounds.";
      consultDoctorIf = "Scalp condition worsens or does not improve after 4 weeks.";
    },
    {
      name = "Benzoyl Peroxide";
      brandName = "Clearasil";
      symptoms = ["Acne", "Pimples", "Blackheads", "Whiteheads"];
      minAge = 12;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Apply thin layer to affected area 1-2 times daily.";
      safetyLevel = #caution;
      warnings = "May bleach fabrics. Start with lower concentration. May cause dryness.";
      avoidIf = "Allergy to benzoyl peroxide.";
      consultDoctorIf = "Acne is severe or does not improve after 12 weeks.";
    },
    {
      name = "Salicylic Acid";
      brandName = "Compound W";
      symptoms = ["Warts", "Corns", "Calluses", "Acne", "Pimples"];
      minAge = 12;
      pregnancySafe = ?false;
      allergyNotes = ["Salicylates"];
      dosageInstructions = "Apply to affected area once or twice daily.";
      safetyLevel = #caution;
      warnings = "Avoid healthy surrounding skin. For external use only.";
      avoidIf = "Diabetes, poor circulation, allergy to salicylates.";
      consultDoctorIf = "Warts are on face or genitals, or do not improve after 12 weeks.";
    },
    {
      name = "Witch Hazel";
      brandName = "Preparation H Wipes";
      symptoms = ["Hemorrhoids", "Rectal Itching", "Rectal Pain", "Rectal Bleeding"];
      minAge = 12;
      pregnancySafe = ?true;
      allergyNotes = [];
      dosageInstructions = "Apply to affected area up to 6 times daily or after each bowel movement.";
      safetyLevel = #safe;
      warnings = "For external use only.";
      avoidIf = "Internal use.";
      consultDoctorIf = "Rectal bleeding persists or hemorrhoids worsen.";
    },
    {
      name = "Phenylephrine HCl Ointment";
      brandName = "Preparation H";
      symptoms = ["Hemorrhoids", "Rectal Itching", "Rectal Pain", "Anal Swelling"];
      minAge = 12;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Apply to affected area up to 4 times daily.";
      safetyLevel = #caution;
      warnings = "Avoid if you have heart disease or high blood pressure.";
      avoidIf = "High blood pressure, heart disease.";
      consultDoctorIf = "Rectal bleeding or hemorrhoids persist more than 7 days.";
    },
    {
      name = "Lidocaine";
      brandName = "Solarcaine";
      symptoms = ["Sunburn", "Minor Burns", "Minor Cuts", "Skin Irritation", "Insect Bites", "Minor Skin Pain"];
      minAge = 2;
      pregnancySafe = null;
      allergyNotes = ["Local anesthetics"];
      dosageInstructions = "Apply to affected area 3-4 times daily.";
      safetyLevel = #safe;
      warnings = "For external use only.";
      avoidIf = "Deep wounds or serious burns.";
      consultDoctorIf = "Burn covers large area or shows signs of infection.";
    },
    {
      name = "Aloe Vera Gel";
      brandName = "Banana Boat Aloe";
      symptoms = ["Sunburn", "Minor Burns", "Skin Irritation", "Dry Skin", "Redness"];
      minAge = 0;
      pregnancySafe = ?true;
      allergyNotes = [];
      dosageInstructions = "Apply liberally to affected skin as needed.";
      safetyLevel = #safe;
      warnings = "For external use only. Some people may be allergic to aloe.";
      avoidIf = "Allergy to aloe vera.";
      consultDoctorIf = "Burns are severe, cover large areas, or show signs of infection.";
    },
    {
      name = "Nicotine Patch";
      brandName = "Nicoderm CQ";
      symptoms = ["Nicotine Craving", "Smoking Cessation", "Withdrawal Symptoms"];
      minAge = 18;
      pregnancySafe = ?false;
      allergyNotes = [];
      dosageInstructions = "Step 1 (21mg/day) for 6 weeks, Step 2 (14mg/day) for 2 weeks, Step 3 (7mg/day) for 2 weeks.";
      safetyLevel = #caution;
      warnings = "Do not smoke while using patch. Remove before MRI.";
      avoidIf = "Pregnancy, recent heart attack.";
      consultDoctorIf = "Under 18, pregnant, or have heart disease.";
    },
    {
      name = "Nicotine Gum";
      brandName = "Nicorette";
      symptoms = ["Nicotine Craving", "Smoking Cessation", "Withdrawal Symptoms"];
      minAge = 18;
      pregnancySafe = ?false;
      allergyNotes = [];
      dosageInstructions = "Use 1 piece every 1-2 hours when urge to smoke occurs. Max 24 pieces/day.";
      safetyLevel = #caution;
      warnings = "Do not eat or drink 15 minutes before or during use. Chew slowly.";
      avoidIf = "Pregnancy, dental problems that prevent chewing.";
      consultDoctorIf = "Under 18 or have serious heart conditions.";
    },
    {
      name = "Mineral Oil Eye Drops";
      brandName = "Systane";
      symptoms = ["Dry Eyes", "Eye Discomfort", "Gritty Eyes", "Burning Eyes"];
      minAge = 0;
      pregnancySafe = ?true;
      allergyNotes = [];
      dosageInstructions = "Instill 1-2 drops in affected eye(s) as needed.";
      safetyLevel = #safe;
      warnings = "Temporary blurred vision may occur.";
      avoidIf = "Allergy to ingredients.";
      consultDoctorIf = "Eye pain or vision changes occur.";
    },
    {
      name = "Debrox";
      brandName = "Debrox";
      symptoms = ["Ear Wax", "Ear Blockage", "Earache", "Ear Discomfort", "Plugged Ear"];
      minAge = 12;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Tilt head, instill 5-10 drops, keep in ear for several minutes, flush gently.";
      safetyLevel = #safe;
      warnings = "Do not use if eardrum is perforated.";
      avoidIf = "Perforated eardrum, ear discharge.";
      consultDoctorIf = "Ear pain, discharge, or hearing loss occurs.";
    },
    {
      name = "Nasal Saline Spray";
      brandName = "Simply Saline";
      symptoms = ["Nasal Congestion", "Stuffy Nose", "Dry Nasal Passages", "Sinus Pressure", "Nasal Irritation"];
      minAge = 0;
      pregnancySafe = ?true;
      allergyNotes = [];
      dosageInstructions = "Spray 1-3 times per nostril as needed.";
      safetyLevel = #safe;
      warnings = "Safe for frequent use. No rebound congestion.";
      avoidIf = "Allergy to saline.";
      consultDoctorIf = "Nasal congestion persists more than 10 days.";
    },
    {
      name = "Acetaminophen/Dextromethorphan/Phenylephrine";
      brandName = "Theraflu";
      symptoms = ["Cold", "Flu", "Cough", "Fever", "Body Ache", "Sore Throat", "Nasal Congestion"];
      minAge = 12;
      pregnancySafe = ?false;
      allergyNotes = [];
      dosageInstructions = "Adults: 1 packet every 4 hours. Max 5 packets/day.";
      safetyLevel = #caution;
      warnings = "May cause drowsiness and dizziness.";
      avoidIf = "High blood pressure or thyroid disorder.";
      consultDoctorIf = "Symptoms persist more than 7 days.";
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
    {
      drug1 = "Nicotine Patch";
      drug2 = "Nicotine Gum";
      interactionType = "Drug-Drug";
      severity = #moderate;
      explanation = "Combining two nicotine replacement therapies can cause nicotine overdose. Only use one at a time unless directed by a doctor.";
    },
    {
      drug1 = "Oxymetazoline";
      drug2 = "MAO Inhibitors";
      interactionType = "Drug-Drug";
      severity = #severe;
      explanation = "Can cause dangerously high blood pressure when combined.";
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

    symptomsSet.toArray().sort(func(a, b) { Text.compare(a, b) });
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
