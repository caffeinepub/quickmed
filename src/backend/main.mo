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
    // ── PAIN / FEVER / INFLAMMATION ──────────────────────────────────────
    {
      name = "Acetaminophen";
      brandName = "Tylenol";
      symptoms = ["Pain", "Fever", "Headache", "Body Ache", "Muscle Pain", "Back Pain", "Neck Pain", "Shoulder Pain", "Knee Pain", "Hip Pain", "Foot Pain", "Wrist Pain", "Ankle Pain", "Toothache", "Menstrual Cramps", "Period Cramps", "Migraine", "Sore Throat", "Earache", "Minor Injury Pain", "PMS", "Premenstrual Symptoms", "Teething Pain", "Post-Vaccination Pain", "Fibromyalgia", "Gout Pain"];
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
      symptoms = ["Pain", "Fever", "Inflammation", "Headache", "Body Ache", "Muscle Pain", "Joint Pain", "Back Pain", "Neck Pain", "Shoulder Pain", "Knee Pain", "Hip Pain", "Wrist Pain", "Ankle Pain", "Foot Pain", "Toothache", "Menstrual Cramps", "Period Cramps", "Migraine", "Swelling", "Minor Injury Pain", "Arthritis Pain", "Sciatica", "Minor Sprain", "Sprains", "Bruise", "PMS", "Premenstrual Symptoms", "Breast Tenderness", "Bursitis", "Tendinitis", "Plantar Fasciitis", "Heel Pain", "Gout Pain", "Shin Splints", "Tennis Elbow", "Golfer's Elbow", "Frozen Shoulder", "Muscle Strain", "Stiff Neck", "Joint Stiffness", "Morning Stiffness"];
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
      symptoms = ["Pain", "Fever", "Headache", "Body Ache", "Muscle Pain", "Inflammation", "Migraine", "Toothache", "Chest Pain (mild, consult doctor first)"];
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
      symptoms = ["Pain", "Body Ache", "Muscle Pain", "Joint Pain", "Back Pain", "Neck Pain", "Shoulder Pain", "Knee Pain", "Hip Pain", "Headache", "Fever", "Inflammation", "Menstrual Cramps", "Period Cramps", "Arthritis Pain", "Swelling", "Migraine", "Sciatica", "Minor Sprain", "Sprains", "Bursitis", "Tendinitis", "Plantar Fasciitis", "Gout Pain", "Shin Splints", "Tennis Elbow"];
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
      name = "Excedrin Migraine";
      brandName = "Excedrin";
      symptoms = ["Migraine", "Headache", "Pain", "Tension Headache", "Cluster Headache", "Sinus Headache"];
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
      name = "Ketoprofen Gel";
      brandName = "Voltaren";
      symptoms = ["Arthritis Pain", "Joint Pain", "Knee Pain", "Hip Pain", "Shoulder Pain", "Wrist Pain", "Ankle Pain", "Muscle Pain", "Back Pain", "Minor Injury Pain", "Sprains", "Tennis Elbow", "Golfer's Elbow", "Carpal Tunnel", "Tendinitis", "Bursitis", "Plantar Fasciitis", "Heel Pain"];
      minAge = 18;
      pregnancySafe = ?false;
      allergyNotes = ["NSAIDs"];
      dosageInstructions = "Apply to affected joint 4 times daily. Massage gently until absorbed.";
      safetyLevel = #caution;
      warnings = "For external use only. Avoid eyes and mucous membranes.";
      avoidIf = "Allergy to NSAIDs, late pregnancy.";
      consultDoctorIf = "Pain does not improve after 21 days.";
    },
    {
      name = "Capsaicin Cream";
      brandName = "Zostrix";
      symptoms = ["Arthritis Pain", "Joint Pain", "Muscle Pain", "Nerve Pain", "Back Pain", "Neck Pain", "Shoulder Pain", "Knee Pain", "Neuropathy", "Shingles Pain", "Tennis Elbow", "Fibromyalgia", "Sciatica", "Diabetic Neuropathy"];
      minAge = 18;
      pregnancySafe = null;
      allergyNotes = ["Capsicum"];
      dosageInstructions = "Apply to affected area 3-4 times daily. Wash hands thoroughly after application.";
      safetyLevel = #caution;
      warnings = "Causes burning sensation initially. Do not use near eyes. Avoid on broken skin.";
      avoidIf = "Allergy to capsicum peppers.";
      consultDoctorIf = "Pain is severe or does not improve after 4 weeks.";
    },
    {
      name = "Menthol Pain Patch";
      brandName = "Salonpas";
      symptoms = ["Muscle Pain", "Back Pain", "Neck Pain", "Shoulder Pain", "Knee Pain", "Joint Pain", "Minor Injury Pain", "Sprains", "Arthritis Pain", "Muscle Spasms", "Tennis Elbow", "Stiff Neck", "Shin Splints", "Muscle Strain"];
      minAge = 12;
      pregnancySafe = null;
      allergyNotes = ["Salicylates", "Menthol"];
      dosageInstructions = "Apply patch to affected area. Leave on for up to 8-12 hours.";
      safetyLevel = #safe;
      warnings = "Do not use on wounds or broken skin.";
      avoidIf = "Allergy to salicylates or menthol.";
      consultDoctorIf = "Pain persists more than 7 days.";
    },
    {
      name = "IcyHot Cream";
      brandName = "IcyHot";
      symptoms = ["Muscle Pain", "Back Pain", "Neck Pain", "Shoulder Pain", "Joint Pain", "Muscle Spasms", "Sprains", "Strains", "Stiff Neck", "Sciatica", "Arthritis Pain", "Minor Injury Pain", "Muscle Strain", "Sore Muscles"];
      minAge = 12;
      pregnancySafe = null;
      allergyNotes = ["Menthol", "Methyl Salicylate"];
      dosageInstructions = "Apply a thin layer to affected area up to 4 times daily.";
      safetyLevel = #safe;
      warnings = "For external use only. Wash hands after use. Avoid eyes and mucous membranes.";
      avoidIf = "Wounds, broken skin, allergy to salicylates.";
      consultDoctorIf = "Pain worsens or does not improve.";
    },
    // ── COLD / FLU / RESPIRATORY ──────────────────────────────────────────
    {
      name = "Pseudoephedrine";
      brandName = "Sudafed";
      symptoms = ["Nasal Congestion", "Sinus Pressure", "Stuffy Nose", "Sinus Congestion", "Cold", "Flu", "Sinus Headache"];
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
      name = "Dextromethorphan";
      brandName = "Robitussin";
      symptoms = ["Cough", "Dry Cough", "Chest Congestion", "Cold", "Flu", "Post-Nasal Drip Cough", "Tickling Throat"];
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
      name = "Guaifenesin";
      brandName = "Mucinex";
      symptoms = ["Cough", "Chest Congestion", "Mucus", "Phlegm", "Productive Cough", "Cold", "Flu", "Thick Mucus", "Blocked Sinuses"];
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
      symptoms = ["Cough", "Congestion", "Nasal Congestion", "Chest Congestion", "Cold", "Sore Muscles", "Muscle Pain", "Back Pain", "Neck Pain", "Muscle Spasms", "Stuffy Nose", "Sinusitis"];
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
      name = "Acetaminophen/Dextromethorphan/Doxylamine";
      brandName = "NyQuil";
      symptoms = ["Cold", "Flu", "Cough", "Fever", "Sinus Pressure", "Body Ache", "Runny Nose", "Sneezing", "Sore Throat", "Insomnia", "Chills", "Night Sweats", "Post-Nasal Drip"];
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
      symptoms = ["Cold", "Flu", "Cough", "Fever", "Sinus Pressure", "Body Ache", "Nasal Congestion", "Runny Nose", "Sore Throat", "Chills", "Post-Nasal Drip", "Sinusitis"];
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
      name = "Acetaminophen/Dextromethorphan/Phenylephrine";
      brandName = "Theraflu";
      symptoms = ["Cold", "Flu", "Cough", "Fever", "Body Ache", "Sore Throat", "Nasal Congestion", "Chills", "Sinus Pressure"];
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
      name = "Oxymetazoline";
      brandName = "Afrin";
      symptoms = ["Nasal Congestion", "Stuffy Nose", "Sinus Congestion", "Sinus Pressure", "Cold", "Sinusitis", "Blocked Sinuses"];
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
      name = "Nasal Saline Spray";
      brandName = "Simply Saline";
      symptoms = ["Nasal Congestion", "Stuffy Nose", "Dry Nasal Passages", "Sinus Pressure", "Nasal Irritation", "Nosebleed", "Cold", "Sinusitis", "Post-Nasal Drip", "Allergic Rhinitis", "Blocked Sinuses"];
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
      name = "Fluticasone Nasal Spray";
      brandName = "Flonase";
      symptoms = ["Nasal Congestion", "Runny Nose", "Sneezing", "Hay Fever", "Allergy", "Seasonal Allergies", "Itchy Nose", "Sinusitis", "Allergic Rhinitis", "Post-Nasal Drip", "Sinus Pressure"];
      minAge = 4;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Adults/Children over 12: 2 sprays per nostril once daily or 1 spray twice daily. Children 4-11: 1 spray per nostril once daily.";
      safetyLevel = #safe;
      warnings = "May take several days for full effect. Avoid spraying into eyes.";
      avoidIf = "Allergy to fluticasone.";
      consultDoctorIf = "Symptoms do not improve after 1 week.";
    },
    {
      name = "Zinc Lozenges";
      brandName = "Cold-Eeze";
      symptoms = ["Cold", "Sore Throat", "Cough", "Nasal Congestion", "Runny Nose", "Immune Support", "Flu"];
      minAge = 12;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Dissolve 1 lozenge in mouth every 2-3 hours at first sign of cold.";
      safetyLevel = #safe;
      warnings = "May cause nausea if taken on empty stomach. Long-term high-dose use may affect copper levels.";
      avoidIf = "Allergy to zinc.";
      consultDoctorIf = "Cold lasts more than 10 days or is accompanied by high fever.";
    },
    {
      name = "Echinacea Supplement";
      brandName = "Nature's Way Echinacea";
      symptoms = ["Cold", "Flu", "Immune Support", "Runny Nose", "Sore Throat", "Upper Respiratory Infection", "Frequent Illness", "Low Immunity"];
      minAge = 12;
      pregnancySafe = null;
      allergyNotes = ["Ragweed", "Daisies", "Chrysanthemums"];
      dosageInstructions = "Adults: 300-500mg three times daily at onset of cold symptoms. Use for up to 10 days.";
      safetyLevel = #caution;
      warnings = "May interact with immunosuppressants. Avoid with autoimmune disorders.";
      avoidIf = "Allergy to ragweed or related plants, autoimmune diseases.";
      consultDoctorIf = "You are immunocompromised or on immunosuppressants.";
    },
    {
      name = "Elderberry Syrup";
      brandName = "Sambucol";
      symptoms = ["Cold", "Flu", "Immune Support", "Sore Throat", "Fever", "Body Ache", "Low Immunity", "Upper Respiratory Infection", "Frequent Illness"];
      minAge = 2;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Adults: 1 tablespoon (15ml) 4 times daily during illness. Children: 1 teaspoon (5ml) 4 times daily.";
      safetyLevel = #safe;
      warnings = "Raw elderberries can be toxic. Only use prepared supplements.";
      avoidIf = "Autoimmune diseases without medical supervision.";
      consultDoctorIf = "You have an autoimmune condition.";
    },
    {
      name = "Nasal Strips";
      brandName = "Breathe Right";
      symptoms = ["Snoring", "Nasal Congestion", "Stuffy Nose", "Difficulty Breathing at Night", "Sleep Problems", "Snoring During Sleep", "Deviated Septum (mild)"];
      minAge = 5;
      pregnancySafe = ?true;
      allergyNotes = [];
      dosageInstructions = "Clean and dry nose, peel and apply strip across nose at bedtime.";
      safetyLevel = #safe;
      warnings = "For external use. Not a treatment for sleep apnea.";
      avoidIf = "Skin irritation or allergy to adhesive.";
      consultDoctorIf = "Snoring is severe or you stop breathing during sleep (sleep apnea).";
    },
    // ── ALLERGIES / ANTIHISTAMINES ────────────────────────────────────────
    {
      name = "Loratadine";
      brandName = "Claritin";
      symptoms = ["Allergy", "Hay Fever", "Runny Nose", "Itchy Eyes", "Sneezing", "Watery Eyes", "Seasonal Allergies", "Skin Rash", "Hives", "Nasal Congestion", "Contact Rash", "Allergic Rhinitis", "Itchy Nose", "Dust Allergy", "Pet Allergy", "Mold Allergy"];
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
      symptoms = ["Allergy", "Hay Fever", "Runny Nose", "Itchy Eyes", "Sneezing", "Watery Eyes", "Seasonal Allergies", "Hives", "Skin Rash", "Nasal Congestion", "Itchy Skin", "Contact Rash", "Poison Ivy", "Poison Oak", "Dust Allergy", "Pet Allergy", "Allergic Rhinitis", "Chronic Hives", "Urticaria"];
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
      symptoms = ["Allergy", "Hay Fever", "Runny Nose", "Itchy Eyes", "Sneezing", "Seasonal Allergies", "Hives", "Watery Eyes", "Allergic Rhinitis", "Dust Allergy", "Pet Allergy", "Chronic Hives", "Urticaria"];
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
      name = "Diphenhydramine";
      brandName = "Benadryl";
      symptoms = ["Allergy", "Runny Nose", "Itchy Eyes", "Cough", "Hives", "Skin Rash", "Itchy Skin", "Sneezing", "Insomnia", "Motion Sickness", "Poison Ivy", "Poison Oak", "Contact Rash", "Chickenpox Itch", "Insect Sting", "Bee Sting", "Urticaria", "Chronic Hives"];
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
      name = "Antihistamine Eye Drops";
      brandName = "Zaditor";
      symptoms = ["Itchy Eyes", "Eye Redness", "Eye Irritation", "Allergy", "Pink Eye", "Conjunctivitis", "Eye Discharge", "Seasonal Allergies", "Watery Eyes", "Allergic Conjunctivitis", "Dust Allergy", "Pet Allergy"];
      minAge = 3;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Instill 1 drop in each affected eye twice daily.";
      safetyLevel = #safe;
      warnings = "Remove contact lenses before use. Wait 10 minutes before reinserting.";
      avoidIf = "Allergy to ketotifen.";
      consultDoctorIf = "Eye symptoms worsen or you develop eye pain.";
    },
    // ── GI / DIGESTIVE ────────────────────────────────────────────────────
    {
      name = "Bismuth Subsalicylate";
      brandName = "Pepto-Bismol";
      symptoms = ["Nausea", "Diarrhea", "Heartburn", "Stomach Upset", "Indigestion", "Vomiting", "Stomach Cramps", "Gas", "Acidity", "Traveler's Diarrhea", "Belching", "Burping", "Acid Taste in Mouth", "Food Poisoning", "Hangover Nausea"];
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
      symptoms = ["Diarrhea", "Loose Stool", "Stomach Cramps", "Traveler's Diarrhea", "IBS Diarrhea", "Food Poisoning"];
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
      name = "Calcium Carbonate";
      brandName = "Tums";
      symptoms = ["Heartburn", "Acid Indigestion", "Indigestion", "Stomach Upset", "Acid Reflux", "Acidity", "Sour Stomach", "Belching", "Burping", "Stomach Burning", "Acid Taste in Mouth", "Regurgitation"];
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
      name = "Famotidine";
      brandName = "Pepcid";
      symptoms = ["Heartburn", "Acid Reflux", "Indigestion", "Acid Indigestion", "Stomach Upset", "Acidity", "GERD", "Stomach Burning", "Sour Stomach", "Regurgitation", "Belching"];
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
      name = "Ranitidine";
      brandName = "Zantac";
      symptoms = ["Heartburn", "Acid Reflux", "Indigestion", "Acid Indigestion", "Acidity", "GERD", "Stomach Burning", "Sour Stomach"];
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
      name = "Omeprazole";
      brandName = "Prilosec OTC";
      symptoms = ["Acidity", "Heartburn", "Acid Reflux", "Acid Indigestion", "GERD", "Sour Stomach", "Stomach Burning", "Regurgitation", "Chronic Heartburn"];
      minAge = 18;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Adults: 20mg once daily before eating for 14 days.";
      safetyLevel = #caution;
      warnings = "OTC use is limited to 14-day courses. May mask symptoms of serious conditions.";
      avoidIf = "Allergy to proton pump inhibitors.";
      consultDoctorIf = "Symptoms persist after 14 days, you have trouble swallowing, or you are vomiting blood.";
    },
    {
      name = "Simethicone";
      brandName = "Gas-X";
      symptoms = ["Gas", "Bloating", "Flatulence", "Stomach Cramps", "Indigestion", "Abdominal Discomfort", "Belching", "Burping", "Baby Colic", "Infant Gas", "Excessive Burping"];
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
      name = "Polyethylene Glycol 3350";
      brandName = "MiraLAX";
      symptoms = ["Constipation", "Irregular Bowel Movement", "Hard Stool", "Bloating", "Straining During Bowel Movement", "Abdominal Discomfort", "IBS Constipation"];
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
      symptoms = ["Constipation", "Hard Stool", "Straining During Bowel Movement", "Hemorrhoids", "Post-Surgery Constipation"];
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
      name = "Bisacodyl";
      brandName = "Dulcolax";
      symptoms = ["Constipation", "Irregular Bowel Movement", "Hard Stool", "Bloating", "Straining During Bowel Movement", "Bowel Preparation"];
      minAge = 6;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Adults: 5-15mg orally once daily at bedtime. Suppository: 10mg rectally.";
      safetyLevel = #caution;
      warnings = "Do not crush or chew tablets. May cause abdominal cramping.";
      avoidIf = "Bowel obstruction, abdominal pain.";
      consultDoctorIf = "No bowel movement after use.";
    },
    {
      name = "Senna";
      brandName = "Senokot";
      symptoms = ["Constipation", "Irregular Bowel Movement", "Hard Stool", "Straining During Bowel Movement", "Hemorrhoids"];
      minAge = 6;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Adults: 2 tablets (17.2mg) once or twice daily.";
      safetyLevel = #caution;
      warnings = "Do not use for more than 1 week without medical advice. May discolor urine.";
      avoidIf = "Bowel obstruction, appendicitis symptoms.";
      consultDoctorIf = "Constipation persists or is accompanied by pain.";
    },
    {
      name = "Psyllium Husk";
      brandName = "Metamucil";
      symptoms = ["Constipation", "Irregular Bowel Movement", "Bloating", "Diarrhea", "Irritable Bowel", "Hemorrhoids", "High Cholesterol", "Blood Sugar Management"];
      minAge = 12;
      pregnancySafe = ?true;
      allergyNotes = [];
      dosageInstructions = "Adults: 1 teaspoon or 1 packet in 8oz of liquid, 1-3 times daily.";
      safetyLevel = #safe;
      warnings = "Take with plenty of water. May cause choking if taken without adequate fluids.";
      avoidIf = "Difficulty swallowing, bowel obstruction.";
      consultDoctorIf = "Constipation persists more than 1 week.";
    },
    {
      name = "Fiber Supplement";
      brandName = "Benefiber";
      symptoms = ["Constipation", "Irregular Bowel Movement", "Bloating", "Hemorrhoids", "High Cholesterol", "Irritable Bowel", "Digestive Health"];
      minAge = 6;
      pregnancySafe = ?true;
      allergyNotes = [];
      dosageInstructions = "Adults: 1 teaspoon or 1 packet, 3 times daily in beverage or food.";
      safetyLevel = #safe;
      warnings = "Take with plenty of water.";
      avoidIf = "Bowel obstruction.";
      consultDoctorIf = "Constipation persists more than 1 week.";
    },
    {
      name = "Probiotic Supplement";
      brandName = "Culturelle";
      symptoms = ["Diarrhea", "Stomach Upset", "Bloating", "Gas", "Constipation", "Irritable Bowel", "Traveler's Diarrhea", "Vaginal Discharge", "Flatulence", "IBS", "Antibiotic-Associated Diarrhea", "Digestive Issues", "Low Immunity", "Recurring Yeast Infection"];
      minAge = 0;
      pregnancySafe = ?true;
      allergyNotes = [];
      dosageInstructions = "Adults: 1-2 capsules daily with or without food.";
      safetyLevel = #safe;
      warnings = "Generally well tolerated. May cause mild gas initially.";
      avoidIf = "Severely compromised immune system without medical supervision.";
      consultDoctorIf = "Digestive symptoms are severe or include blood.";
    },
    {
      name = "Ginger Supplement";
      brandName = "Nature's Bounty Ginger";
      symptoms = ["Nausea", "Motion Sickness", "Morning Sickness", "Vomiting", "Stomach Upset", "Indigestion", "Bloating", "Gas", "Nausea from Chemotherapy", "Post-Surgery Nausea"];
      minAge = 0;
      pregnancySafe = ?true;
      allergyNotes = [];
      dosageInstructions = "Adults: 250mg-1000mg up to 4 times daily.";
      safetyLevel = #safe;
      warnings = "May cause mild heartburn in some people at high doses.";
      avoidIf = "Allergy to ginger.";
      consultDoctorIf = "Nausea is severe or prolonged.";
    },
    {
      name = "Oral Rehydration Salts";
      brandName = "Pedialyte";
      symptoms = ["Diarrhea", "Vomiting", "Dehydration", "Nausea", "Dizziness", "Fatigue", "Weakness", "Traveler's Diarrhea", "Heat Exhaustion", "Hangover", "Excessive Sweating", "Dry Mouth"];
      minAge = 0;
      pregnancySafe = ?true;
      allergyNotes = [];
      dosageInstructions = "Drink as directed on label to replace fluids and electrolytes.";
      safetyLevel = #safe;
      warnings = "Does not stop diarrhea; replaces fluids and electrolytes lost.";
      avoidIf = "Electrolyte restrictions.";
      consultDoctorIf = "Diarrhea or vomiting persists more than 2 days, especially in infants.";
    },
    // ── SLEEP / ANXIETY ───────────────────────────────────────────────────
    {
      name = "Doxylamine Succinate";
      brandName = "Unisom";
      symptoms = ["Insomnia", "Difficulty Sleeping", "Sleep Problems", "Restlessness", "Anxiety", "Nervousness"];
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
      symptoms = ["Insomnia", "Difficulty Sleeping", "Jet Lag", "Sleep Problems", "Restlessness", "Night Sweats", "Shift Work Sleep Disorder", "Sleep-Wake Cycle Issues", "Travel Fatigue"];
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
      name = "Valerian Root";
      brandName = "Nature Made Valerian";
      symptoms = ["Insomnia", "Anxiety", "Stress", "Nervousness", "Restlessness", "Difficulty Sleeping", "Sleep Problems", "Restless Legs"];
      minAge = 18;
      pregnancySafe = ?false;
      allergyNotes = [];
      dosageInstructions = "Adults: 300-600mg taken 30 minutes to 2 hours before bedtime.";
      safetyLevel = #caution;
      warnings = "May cause drowsiness. Do not drive after use.";
      avoidIf = "Pregnancy, breastfeeding.";
      consultDoctorIf = "Sleep problems persist more than 2 weeks.";
    },
    {
      name = "St. John's Wort";
      brandName = "Nature's Bounty St. John's Wort";
      symptoms = ["Anxiety", "Nervousness", "Stress", "Mood Changes", "Mild Depression", "Restlessness", "Insomnia", "Seasonal Affective Disorder", "Low Mood"];
      minAge = 18;
      pregnancySafe = ?false;
      allergyNotes = [];
      dosageInstructions = "Adults: 300mg three times daily with meals.";
      safetyLevel = #caution;
      warnings = "Interacts with many medications. May cause sun sensitivity.";
      avoidIf = "Pregnancy, bipolar disorder, taking prescription medications.";
      consultDoctorIf = "You are on any prescription medications before use.";
    },
    {
      name = "Magnesium Supplement";
      brandName = "Natural Calm";
      symptoms = ["Leg Cramps", "Muscle Cramps", "Night Cramps", "Muscle Spasms", "Restlessness", "Anxiety", "Stress", "Constipation", "Difficulty Sleeping", "Fatigue", "Low Energy", "Restless Legs", "Headache", "Migraine Prevention", "PMS"];
      minAge = 12;
      pregnancySafe = ?true;
      allergyNotes = [];
      dosageInstructions = "Adults: 200-400mg daily. Take with food.";
      safetyLevel = #safe;
      warnings = "High doses may cause diarrhea. Start with lower dose and increase gradually.";
      avoidIf = "Kidney disease.";
      consultDoctorIf = "Muscle cramps are severe or accompanied by swelling.";
    },
    // ── MOTION SICKNESS / VERTIGO ─────────────────────────────────────────
    {
      name = "Dimenhydrinate";
      brandName = "Dramamine";
      symptoms = ["Motion Sickness", "Nausea", "Vomiting", "Dizziness", "Vertigo", "Sea Sickness", "Car Sickness", "Air Sickness"];
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
      symptoms = ["Motion Sickness", "Nausea", "Dizziness", "Vertigo", "Tinnitus", "Ringing in Ears", "Sea Sickness", "Car Sickness", "Labyrinthitis", "Meniere's Disease Symptoms"];
      minAge = 12;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Adults: 25-50mg one hour before travel. Repeat every 24 hours.";
      safetyLevel = #caution;
      warnings = "May cause drowsiness.";
      avoidIf = "Glaucoma, enlarged prostate.";
      consultDoctorIf = "Vertigo or dizziness is severe.";
    },
    // ── SKIN CONDITIONS ───────────────────────────────────────────────────
    {
      name = "Hydrocortisone Cream";
      brandName = "Cortaid";
      symptoms = ["Skin Rash", "Itchy Skin", "Eczema", "Insect Bites", "Hives", "Contact Dermatitis", "Redness", "Minor Skin Irritation", "Poison Ivy", "Poison Oak", "Contact Rash", "Psoriasis", "Rosacea", "Skin Redness", "Razor Burn", "Chafing", "Skin Chafing", "Heat Rash", "Prickly Heat", "Intertrigo", "Chickenpox Itch", "Dermatitis", "Seborrheic Dermatitis"];
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
      name = "Calamine Lotion";
      brandName = "Caladryl";
      symptoms = ["Poison Ivy", "Poison Oak", "Contact Rash", "Itchy Skin", "Insect Bites", "Skin Rash", "Chickenpox", "Hives", "Contact Dermatitis", "Mosquito Bite", "Bee Sting", "Spider Bite", "Flea Bite", "Sunburn Itch"];
      minAge = 2;
      pregnancySafe = ?true;
      allergyNotes = [];
      dosageInstructions = "Apply to affected area 3-4 times daily. Allow to dry.";
      safetyLevel = #safe;
      warnings = "For external use only. Shake well before using.";
      avoidIf = "Open wounds or blisters that are oozing.";
      consultDoctorIf = "Rash covers large areas, near eyes, or does not improve.";
    },
    {
      name = "Clotrimazole";
      brandName = "Lotrimin";
      symptoms = ["Athlete's Foot", "Jock Itch", "Ringworm", "Fungal Infection", "Itchy Skin", "Nail Fungus", "Toenail Fungus", "Tinea Versicolor", "Skin Fungus"];
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
      symptoms = ["Yeast Infection", "Vaginal Itching", "Vaginal Discharge", "Fungal Infection", "Athlete's Foot", "Nail Fungus", "Jock Itch", "Ringworm", "Tinea Versicolor"];
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
      name = "Zinc Pyrithione Shampoo";
      brandName = "Head & Shoulders";
      symptoms = ["Dandruff", "Flaky Scalp", "Itchy Scalp", "Seborrheic Dermatitis", "Cradle Cap", "Oily Scalp", "Scalp Flaking"];
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
      symptoms = ["Acne", "Pimples", "Blackheads", "Whiteheads", "Back Acne", "Cystic Acne (mild)", "Folliculitis"];
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
      symptoms = ["Warts", "Corns", "Calluses", "Acne", "Pimples", "Blackheads", "Psoriasis", "Cracked Heels", "Rough Skin", "Keratosis Pilaris"];
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
      name = "Aloe Vera Gel";
      brandName = "Banana Boat Aloe";
      symptoms = ["Sunburn", "Minor Burns", "Skin Irritation", "Dry Skin", "Redness", "Minor Wound", "Skin Redness", "Razor Burn", "Chafing", "Skin Chafing", "Heat Rash", "Windburn", "Chilblains", "Cracked Heels", "Dry Hands", "Cracked Skin"];
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
      name = "Lidocaine";
      brandName = "Solarcaine";
      symptoms = ["Sunburn", "Minor Burns", "Minor Cuts", "Skin Irritation", "Insect Bites", "Minor Skin Pain", "Minor Wound", "Scrape", "Cut", "Laceration", "Razor Burn", "Blister Pain"];
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
      name = "Triple Antibiotic Ointment";
      brandName = "Neosporin";
      symptoms = ["Minor Wound", "Cut", "Scrape", "Laceration", "Minor Burns", "Insect Bites", "Minor Cuts", "Blisters", "Infected Blister", "Ingrown Toenail", "Folliculitis", "Impetigo (mild)"];
      minAge = 0;
      pregnancySafe = ?true;
      allergyNotes = ["Neomycin", "Bacitracin"];
      dosageInstructions = "Clean wound, apply small amount 1-3 times daily, cover with bandage.";
      safetyLevel = #safe;
      warnings = "For external use only. Some people may develop a rash (neomycin sensitivity).";
      avoidIf = "Allergy to neomycin or bacitracin.";
      consultDoctorIf = "Wound shows signs of infection (redness, swelling, warmth, pus).";
    },
    {
      name = "Witch Hazel";
      brandName = "Preparation H Wipes";
      symptoms = ["Hemorrhoids", "Rectal Itching", "Rectal Pain", "Rectal Bleeding", "Skin Rash", "Minor Skin Irritation", "Razor Burn", "Acne", "Puffy Eyes", "Eye Puffiness", "Bruise"];
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
      symptoms = ["Hemorrhoids", "Rectal Itching", "Rectal Pain", "Anal Swelling", "Internal Hemorrhoids"];
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
      name = "Hemorrhoid Suppositories";
      brandName = "Anusol";
      symptoms = ["Hemorrhoids", "Rectal Pain", "Rectal Itching", "Anal Swelling", "Internal Hemorrhoids"];
      minAge = 12;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Insert one suppository rectally up to 4 times daily.";
      safetyLevel = #caution;
      warnings = "For rectal use only.";
      avoidIf = "Allergy to ingredients.";
      consultDoctorIf = "Rectal bleeding persists or hemorrhoids worsen.";
    },
    {
      name = "Permethrin";
      brandName = "Nix";
      symptoms = ["Head Lice", "Lice", "Scabies", "Itchy Scalp", "Body Lice", "Pubic Lice"];
      minAge = 2;
      pregnancySafe = null;
      allergyNotes = ["Chrysanthemums", "Pyrethrins"];
      dosageInstructions = "Apply to hair or skin as directed on package. Leave on for specified time, then rinse.";
      safetyLevel = #caution;
      warnings = "For external use only. Avoid contact with eyes.";
      avoidIf = "Allergy to pyrethrins or chrysanthemums.";
      consultDoctorIf = "Lice or scabies persist after treatment.";
    },
    {
      name = "Zinc Oxide Diaper Cream";
      brandName = "Desitin";
      symptoms = ["Diaper Rash", "Baby Rash", "Skin Rash", "Skin Irritation", "Chafing", "Skin Chafing", "Heat Rash", "Prickly Heat", "Intertrigo"];
      minAge = 0;
      pregnancySafe = ?true;
      allergyNotes = [];
      dosageInstructions = "Apply liberally to clean, dry diaper area at each diaper change.";
      safetyLevel = #safe;
      warnings = "For external use only.";
      avoidIf = "Deep skin infection.";
      consultDoctorIf = "Rash persists more than 7 days, bleeds, or shows signs of infection.";
    },
    {
      name = "Antifungal Powder";
      brandName = "Zeasorb";
      symptoms = ["Athlete's Foot", "Jock Itch", "Foot Odor", "Excessive Sweating", "Hyperhidrosis", "Sweaty Feet", "Fungal Infection", "Intertrigo", "Chafing"];
      minAge = 2;
      pregnancySafe = ?true;
      allergyNotes = [];
      dosageInstructions = "Apply powder to affected area once or twice daily.";
      safetyLevel = #safe;
      warnings = "For external use only. Avoid inhaling powder.";
      avoidIf = "Allergy to ingredients.";
      consultDoctorIf = "Infection does not improve after 4 weeks.";
    },
    // ── EYES ──────────────────────────────────────────────────────────────
    {
      name = "Carboxymethylcellulose Eye Drops";
      brandName = "Refresh Tears";
      symptoms = ["Dry Eyes", "Eye Irritation", "Eye Discomfort", "Burning Eyes", "Gritty Eyes", "Eye Strain", "Eye Fatigue", "Screen Fatigue", "Eye Redness", "Eye Dryness", "Contact Lens Discomfort"];
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
      name = "Mineral Oil Eye Drops";
      brandName = "Systane";
      symptoms = ["Dry Eyes", "Eye Discomfort", "Gritty Eyes", "Burning Eyes", "Eye Fatigue", "Screen Fatigue", "Contact Lens Discomfort"];
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
      name = "Phenylephrine (Eye Drops)";
      brandName = "Visine";
      symptoms = ["Eye Redness", "Red Eyes", "Eye Irritation", "Bloodshot Eyes", "Eye Strain", "Eye Fatigue", "Screen Fatigue"];
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
      name = "Warm Compress Eye Pads";
      brandName = "TheraPearl Eye-ssential";
      symptoms = ["Stye", "Eye Discomfort", "Dry Eyes", "Eye Fatigue", "Eye Puffiness", "Puffy Eyes", "Eyelid Swelling", "Chalazion", "Blepharitis", "Eye Stye"];
      minAge = 0;
      pregnancySafe = ?true;
      allergyNotes = [];
      dosageInstructions = "Apply warm compress to closed eyelid for 10-15 minutes, 3-4 times daily.";
      safetyLevel = #safe;
      warnings = "Do not apply directly to eyeball. Check temperature before applying.";
      avoidIf = "Active eye infection without medical diagnosis.";
      consultDoctorIf = "Stye does not improve after 1-2 weeks or eye becomes very painful.";
    },
    {
      name = "Antibiotic Eye Wash";
      brandName = "Bausch & Lomb Eye Wash";
      symptoms = ["Pink Eye", "Conjunctivitis", "Eye Discharge", "Eye Irritation", "Eye Redness", "Stye", "Eye Infection", "Allergic Conjunctivitis", "Eye Crusting"];
      minAge = 0;
      pregnancySafe = ?true;
      allergyNotes = [];
      dosageInstructions = "Flush eye with solution as directed on label. For minor irritation only.";
      safetyLevel = #safe;
      warnings = "OTC eye washes relieve irritation. See a doctor for bacterial conjunctivitis requiring antibiotic drops.";
      avoidIf = "Severe eye pain or vision changes.";
      consultDoctorIf = "Eye discharge is yellow or green, or symptoms worsen.";
    },
    // ── EAR CONDITIONS ────────────────────────────────────────────────────
    {
      name = "Debrox";
      brandName = "Debrox";
      symptoms = ["Ear Wax", "Ear Blockage", "Earache", "Ear Discomfort", "Plugged Ear", "Hearing Muffled", "Ear Fullness"];
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
      name = "Warm Ear Drops";
      brandName = "Swim-Ear";
      symptoms = ["Swimmer's Ear", "Outer Ear Pain", "Ear Discomfort", "Ear Itching", "Plugged Ear", "Water in Ear", "Ear Fullness"];
      minAge = 2;
      pregnancySafe = ?true;
      allergyNotes = [];
      dosageInstructions = "Tilt head, instill 4-5 drops, keep in ear 30 seconds, then drain.";
      safetyLevel = #safe;
      warnings = "Do not use if eardrum is perforated or if there is ear discharge.";
      avoidIf = "Perforated eardrum, ear discharge.";
      consultDoctorIf = "Ear pain is severe, with discharge, or hearing is affected.";
    },
    // ── DENTAL / ORAL ─────────────────────────────────────────────────────
    {
      name = "Benzocaine";
      brandName = "Orajel";
      symptoms = ["Toothache", "Gum Pain", "Mouth Sore", "Canker Sore", "Sore Throat", "Teething Pain", "Tooth Sensitivity", "Sensitive Teeth", "Gingivitis", "Gum Irritation", "Braces Pain", "Denture Irritation"];
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
      symptoms = ["Sore Throat", "Throat Pain", "Throat Irritation", "Mouth Sore", "Canker Sore", "Throat Dryness", "Strep Throat (mild)"];
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
      name = "Antiseptic Mouthwash";
      brandName = "Listerine";
      symptoms = ["Bad Breath", "Halitosis", "Gingivitis", "Gum Bleeding", "Mouth Sore", "Sore Throat", "Tooth Sensitivity", "Plaque", "Gum Disease", "Gum Inflammation", "Dental Hygiene", "Mouth Ulcer"];
      minAge = 6;
      pregnancySafe = ?true;
      allergyNotes = [];
      dosageInstructions = "Rinse with 20ml for 30 seconds twice daily after brushing.";
      safetyLevel = #safe;
      warnings = "Do not swallow. Alcohol-containing mouthwash may irritate mouth sores.";
      avoidIf = "Children under 6.";
      consultDoctorIf = "Gum disease is severe or does not improve.";
    },
    {
      name = "Fluoride Toothpaste";
      brandName = "Sensodyne";
      symptoms = ["Tooth Sensitivity", "Sensitive Teeth", "Toothache", "Gingivitis", "Bad Breath", "Halitosis", "Gum Pain", "Enamel Erosion", "Dental Cavities"];
      minAge = 0;
      pregnancySafe = ?true;
      allergyNotes = [];
      dosageInstructions = "Brush teeth twice daily for 2 minutes. Do not swallow.";
      safetyLevel = #safe;
      warnings = "Keep out of reach of children. If more than toothbrushing amount is swallowed, call poison control.";
      avoidIf = "Allergy to fluoride (rare).";
      consultDoctorIf = "Tooth sensitivity is severe or persists.";
    },
    {
      name = "Artificial Saliva / Dry Mouth Spray";
      brandName = "Biotene";
      symptoms = ["Dry Mouth", "Mouth Dryness", "Bad Breath", "Halitosis", "Sore Throat", "Difficulty Swallowing", "Medication-Induced Dry Mouth"];
      minAge = 0;
      pregnancySafe = ?true;
      allergyNotes = [];
      dosageInstructions = "Spray or apply gel inside mouth as needed.";
      safetyLevel = #safe;
      warnings = "Does not treat underlying causes of dry mouth.";
      avoidIf = "Allergy to ingredients.";
      consultDoctorIf = "Dry mouth is persistent and severe.";
    },
    // ── WOMEN'S HEALTH ────────────────────────────────────────────────────
    {
      name = "Ibuprofen/Pamabrom";
      brandName = "Midol";
      symptoms = ["Menstrual Cramps", "Period Cramps", "PMS", "Premenstrual Symptoms", "Bloating", "Water Retention", "Breast Tenderness", "Backache", "Headache", "Fatigue", "Mood Swings", "Pelvic Pain"];
      minAge = 12;
      pregnancySafe = ?false;
      allergyNotes = ["NSAIDs"];
      dosageInstructions = "Adults: Take as directed on package, usually 2 caplets every 4 hours. Max 6 caplets/day.";
      safetyLevel = #caution;
      warnings = "Contains ibuprofen and diuretic. Avoid in late pregnancy.";
      avoidIf = "Kidney disease, gastric ulcer, late pregnancy.";
      consultDoctorIf = "Menstrual pain is severe or accompanied by heavy bleeding.";
    },
    {
      name = "Black Cohosh";
      brandName = "Remifemin";
      symptoms = ["Hot Flashes", "Night Sweats", "Menopause Symptoms", "PMS", "Mood Changes", "Restlessness", "Perimenopause", "Menopausal Anxiety", "Vaginal Dryness"];
      minAge = 18;
      pregnancySafe = ?false;
      allergyNotes = ["Aspirin", "Salicylates"];
      dosageInstructions = "Adults: 20-40mg twice daily.";
      safetyLevel = #caution;
      warnings = "Not recommended for women with estrogen-sensitive cancers.";
      avoidIf = "Hormone-sensitive conditions, liver disease, pregnancy.";
      consultDoctorIf = "Hot flashes are severe or accompanied by other symptoms.";
    },
    // ── URINARY HEALTH ────────────────────────────────────────────────────
    {
      name = "Cranberry Supplement";
      brandName = "AZO Cranberry";
      symptoms = ["UTI Symptoms", "Burning Urination", "Frequent Urination", "Urinary Discomfort", "Bladder Irritation", "Urinary Tract Infection Prevention", "Recurrent UTI"];
      minAge = 12;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Adults: Take as directed on package, usually 1-2 tablets/capsules daily.";
      safetyLevel = #safe;
      warnings = "Does not treat active infections; seek medical care if you have a UTI.";
      avoidIf = "Allergy to cranberry. Kidney stones (oxalate).";
      consultDoctorIf = "You have signs of a UTI (burning, pain, fever). Cranberry is preventive, not a cure.";
    },
    {
      name = "Phenazopyridine";
      brandName = "AZO Standard";
      symptoms = ["UTI Symptoms", "Burning Urination", "Painful Urination", "Frequent Urination", "Urinary Discomfort", "Bladder Irritation", "Urgency"];
      minAge = 12;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Adults: 200mg 3 times daily after meals. Max 2 days OTC use.";
      safetyLevel = #caution;
      warnings = "Turns urine orange or red. Does not treat infection -- see a doctor for antibiotics.";
      avoidIf = "Kidney disease, allergy to phenazopyridine.";
      consultDoctorIf = "Symptoms do not improve in 2 days or you develop fever.";
    },
    // ── VITAMINS / SUPPLEMENTS ────────────────────────────────────────────
    {
      name = "Iron Supplement";
      brandName = "Slow Fe";
      symptoms = ["Fatigue", "Low Energy", "Iron Deficiency", "Vitamin Deficiency", "Weakness", "Dizziness", "Pale Skin", "Loss of Appetite", "Shortness of Breath", "Cold Hands and Feet", "Brain Fog", "Hair Loss", "Hair Thinning", "Brittle Nails"];
      minAge = 0;
      pregnancySafe = ?true;
      allergyNotes = [];
      dosageInstructions = "Adults: 45-65mg elemental iron per day. Take on empty stomach or with vitamin C for best absorption.";
      safetyLevel = #caution;
      warnings = "May cause constipation, dark stools, and stomach upset.";
      avoidIf = "Hemochromatosis (iron overload), inflammatory bowel disease.";
      consultDoctorIf = "Fatigue persists despite supplementation or you suspect iron deficiency.";
    },
    {
      name = "Vitamin B12 Supplement";
      brandName = "Nature Made B12";
      symptoms = ["Fatigue", "Low Energy", "Vitamin Deficiency", "Brain Fog", "Weakness", "Numbness", "Tingling", "Memory Problems", "Mood Changes", "Hair Loss", "Pale Skin"];
      minAge = 0;
      pregnancySafe = ?true;
      allergyNotes = [];
      dosageInstructions = "Adults: 500-2000mcg daily or as directed.";
      safetyLevel = #safe;
      warnings = "Water-soluble; excess is excreted. Generally safe in high doses.";
      avoidIf = "Allergy to cobalt or cobalamin.";
      consultDoctorIf = "Neurological symptoms persist.";
    },
    {
      name = "Vitamin D3 Supplement";
      brandName = "Nature Made Vitamin D3";
      symptoms = ["Fatigue", "Low Energy", "Vitamin Deficiency", "Weakness", "Bone Pain", "Muscle Weakness", "Mood Changes", "Low Immunity", "Frequent Illness", "Back Pain", "Hair Loss", "Seasonal Affective Disorder", "Depression (mild)"];
      minAge = 0;
      pregnancySafe = ?true;
      allergyNotes = [];
      dosageInstructions = "Adults: 1000-2000 IU daily with a fat-containing meal.";
      safetyLevel = #safe;
      warnings = "Fat-soluble; avoid very high doses without medical supervision.";
      avoidIf = "Hypercalcemia, sarcoidosis.";
      consultDoctorIf = "Fatigue persists or you suspect a deficiency.";
    },
    {
      name = "Vitamin C Supplement";
      brandName = "Emergen-C";
      symptoms = ["Cold", "Flu", "Immune Support", "Fatigue", "Low Energy", "Vitamin Deficiency", "Sore Throat", "Frequent Illness", "Low Immunity", "Slow Wound Healing", "Bleeding Gums"];
      minAge = 0;
      pregnancySafe = ?true;
      allergyNotes = [];
      dosageInstructions = "Adults: 500-1000mg daily. Higher doses may cause diarrhea.";
      safetyLevel = #safe;
      warnings = "High doses (above 2000mg/day) may cause kidney stones and diarrhea.";
      avoidIf = "Kidney stones, hemochromatosis.";
      consultDoctorIf = "You are taking blood thinners or have kidney disease.";
    },
    {
      name = "Biotin Supplement";
      brandName = "Nature's Bounty Biotin";
      symptoms = ["Hair Loss", "Hair Thinning", "Brittle Nails", "Nail Brittleness", "Dry Skin", "Vitamin Deficiency", "Weak Nails", "Yellow Nails"];
      minAge = 0;
      pregnancySafe = ?true;
      allergyNotes = [];
      dosageInstructions = "Adults: 2500-5000mcg daily.";
      safetyLevel = #safe;
      warnings = "High doses may interfere with certain lab tests. Inform your doctor before testing.";
      avoidIf = "Allergy to biotin.";
      consultDoctorIf = "Hair loss is sudden, patchy, or accompanied by other symptoms.";
    },
    {
      name = "Glucosamine/Chondroitin";
      brandName = "Osteo Bi-Flex";
      symptoms = ["Joint Pain", "Arthritis Pain", "Knee Pain", "Hip Pain", "Joint Stiffness", "Morning Stiffness", "Cartilage Wear", "Osteoarthritis", "Joint Creaking", "Shoulder Pain"];
      minAge = 18;
      pregnancySafe = null;
      allergyNotes = ["Shellfish"];
      dosageInstructions = "Adults: 1500mg glucosamine and 1200mg chondroitin daily (can be split into 2-3 doses).";
      safetyLevel = #safe;
      warnings = "May take several weeks to notice benefits. Check label if you have shellfish allergy.";
      avoidIf = "Shellfish allergy (some products), pregnancy.";
      consultDoctorIf = "Joint pain is severe or accompanied by swelling and redness.";
    },
    {
      name = "Omega-3 Fish Oil";
      brandName = "Nature Made Fish Oil";
      symptoms = ["Joint Pain", "Inflammation", "Arthritis Pain", "Dry Skin", "Dry Eyes", "Brain Fog", "Mood Changes", "High Cholesterol", "Heart Health", "Joint Stiffness"];
      minAge = 0;
      pregnancySafe = ?true;
      allergyNotes = ["Fish"];
      dosageInstructions = "Adults: 1000-3000mg of combined EPA/DHA daily with meals.";
      safetyLevel = #safe;
      warnings = "May cause fishy breath and GI upset. High doses may thin blood.";
      avoidIf = "Fish or shellfish allergy, bleeding disorders.";
      consultDoctorIf = "You are on blood thinners.";
    },
    {
      name = "Turmeric/Curcumin Supplement";
      brandName = "Qunol Turmeric";
      symptoms = ["Joint Pain", "Inflammation", "Arthritis Pain", "Back Pain", "Muscle Pain", "Digestive Issues", "Bloating", "Irritable Bowel", "Antioxidant Support"];
      minAge = 18;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Adults: 500-1000mg of curcumin daily with meals and black pepper extract.";
      safetyLevel = #safe;
      warnings = "May have blood-thinning effects. May interfere with iron absorption.";
      avoidIf = "Gallbladder disease, bleeding disorders.";
      consultDoctorIf = "You are on blood thinners or have gallbladder problems.";
    },
    // ── NICOTINE CESSATION ────────────────────────────────────────────────
    {
      name = "Nicotine Patch";
      brandName = "Nicoderm CQ";
      symptoms = ["Nicotine Craving", "Smoking Cessation", "Withdrawal Symptoms", "Anxiety from Quitting"];
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
      symptoms = ["Nicotine Craving", "Smoking Cessation", "Withdrawal Symptoms", "Anxiety", "Nervousness", "Stress", "Irritability from Quitting"];
      minAge = 18;
      pregnancySafe = ?false;
      allergyNotes = [];
      dosageInstructions = "Use 1 piece every 1-2 hours when urge to smoke occurs. Max 24 pieces/day.";
      safetyLevel = #caution;
      warnings = "Do not eat or drink 15 minutes before or during use. Chew slowly.";
      avoidIf = "Pregnancy, dental problems that prevent chewing.";
      consultDoctorIf = "Under 18 or have serious heart conditions.";
    },
    // ── COLD SORES / LIP CARE ─────────────────────────────────────────────
    {
      name = "Docosanol";
      brandName = "Abreva";
      symptoms = ["Cold Sore", "Fever Blister", "Lip Blister", "Chapped Lips", "Lip Dryness", "Herpes Labialis"];
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
      name = "Lip Balm with SPF";
      brandName = "Carmex";
      symptoms = ["Chapped Lips", "Lip Dryness", "Dry Lips", "Cold Sore", "Sunburn", "Cracked Lips", "Lip Irritation"];
      minAge = 0;
      pregnancySafe = ?true;
      allergyNotes = [];
      dosageInstructions = "Apply to lips as needed throughout the day.";
      safetyLevel = #safe;
      warnings = "Avoid if allergic to any ingredient.";
      avoidIf = "Allergy to ingredients.";
      consultDoctorIf = "Lips are severely cracked and infected.";
    },
    // ── SKIN CARE / HAIR ──────────────────────────────────────────────────
    {
      name = "Coal Tar Shampoo";
      brandName = "Neutrogena T/Gel";
      symptoms = ["Dandruff", "Psoriasis", "Seborrheic Dermatitis", "Flaky Scalp", "Itchy Scalp", "Scalp Psoriasis"];
      minAge = 2;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Use 2-3 times per week. Lather, leave on 5 minutes, then rinse thoroughly.";
      safetyLevel = #caution;
      warnings = "Avoid sun exposure on treated areas. May stain light-colored hair.";
      avoidIf = "Allergy to coal tar.";
      consultDoctorIf = "Scalp condition worsens or does not improve after 6 weeks.";
    },
    // ── WOUND CARE ────────────────────────────────────────────────────────
    {
      name = "Pyrantel Pamoate";
      brandName = "Pin-X";
      symptoms = ["Pinworm", "Intestinal Worms", "Rectal Itching", "Anal Itching", "Perianal Itching"];
      minAge = 2;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Single dose of 11mg/kg (max 1g). Repeat in 2 weeks if needed.";
      safetyLevel = #caution;
      warnings = "Treat all household members simultaneously. Wash bedding and clothing.";
      avoidIf = "Liver disease.";
      consultDoctorIf = "Infection persists after two treatments.";
    },
    // ── NASAL / SINUS ─────────────────────────────────────────────────────
    {
      name = "Fluticasone Nasal Spray";
      brandName = "Flonase";
      symptoms = ["Nasal Congestion", "Runny Nose", "Sneezing", "Hay Fever", "Allergy", "Seasonal Allergies", "Itchy Nose", "Sinusitis", "Allergic Rhinitis", "Post-Nasal Drip", "Sinus Pressure", "Nasal Polyps (mild)"];
      minAge = 4;
      pregnancySafe = null;
      allergyNotes = [];
      dosageInstructions = "Adults/Children over 12: 2 sprays per nostril once daily or 1 spray twice daily.";
      safetyLevel = #safe;
      warnings = "May take several days for full effect.";
      avoidIf = "Allergy to fluticasone.";
      consultDoctorIf = "Symptoms do not improve after 1 week.";
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
    {
      drug1 = "Omeprazole";
      drug2 = "Clopidogrel";
      interactionType = "Drug-Drug";
      severity = #moderate;
      explanation = "Omeprazole can reduce the effectiveness of clopidogrel (a blood thinner). Consult your doctor if you take both.";
    },
    {
      drug1 = "St. John's Wort";
      drug2 = "Antidepressants";
      interactionType = "Drug-Drug";
      severity = #severe;
      explanation = "Combining St. John's Wort with antidepressants can cause serotonin syndrome. Do not use together.";
    },
    {
      drug1 = "Iron Supplement";
      drug2 = "Calcium Carbonate";
      interactionType = "Drug-Drug";
      severity = #moderate;
      explanation = "Calcium can reduce iron absorption. Take iron and calcium supplements at least 2 hours apart.";
    },
    {
      drug1 = "Magnesium Supplement";
      drug2 = "Certain Drugs";
      interactionType = "Drug-Drug";
      severity = #mild;
      explanation = "Magnesium can reduce absorption of some antibiotics and medications. Take at least 2 hours apart.";
    },
    {
      drug1 = "Omega-3 Fish Oil";
      drug2 = "Blood Thinners";
      interactionType = "Drug-Drug";
      severity = #moderate;
      explanation = "High doses of fish oil may enhance the effects of blood thinners, increasing bleeding risk.";
    },
    {
      drug1 = "Turmeric/Curcumin";
      drug2 = "Blood Thinners";
      interactionType = "Drug-Drug";
      severity = #moderate;
      explanation = "Curcumin may have blood-thinning effects and can enhance the action of anticoagulants.";
    },
    {
      drug1 = "Aspirin";
      drug2 = "Alcohol";
      interactionType = "Drug-Food";
      severity = #moderate;
      explanation = "Combining aspirin with alcohol increases the risk of stomach bleeding.";
    },
    {
      drug1 = "Valerian Root";
      drug2 = "Alcohol";
      interactionType = "Drug-Food";
      severity = #moderate;
      explanation = "Both valerian and alcohol have sedative effects; combining them increases drowsiness and impairment.";
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
