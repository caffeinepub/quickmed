# QuickMed

## Current State
Backend has ~45 OTC medicines covering ~90 unique symptoms. Frontend loads symptoms from backend via `getAllSymptoms()` and displays them with incremental "Load More" (20 at a time).

## Requested Changes (Diff)

### Add
- ~20 new OTC medicines covering: fatigue/vitamins, wound care, poison ivy, lice, pinworm, nail fungus, bad breath, tooth sensitivity, pink eye/stye, swimmer's ear, UTI urinary relief, PMS/menstrual, leg cramps/magnesium, diaper rash, chapped lips, razor burn/chafing, night sweats/hot flashes, water retention, anxiety/nervousness, eye strain, dry mouth, nosebleed, tinnitus
- New symptoms: Fatigue, Low Energy, Vitamin Deficiency, Iron Deficiency, Anxiety, Nervousness, Stress, Minor Wound, Scrape, Cut, Laceration, Poison Ivy, Poison Oak, Contact Rash, Head Lice, Lice, Pinworm, Nail Fungus, Toenail Fungus, Bad Breath, Halitosis, Tooth Sensitivity, Sensitive Teeth, Gingivitis, Gum Bleeding, Pink Eye, Conjunctivitis, Eye Discharge, Stye, Swimmer's Ear, Outer Ear Pain, UTI Symptoms, Burning Urination, Frequent Urination, PMS, Premenstrual Symptoms, Breast Tenderness, Leg Cramps, Muscle Cramps, Night Cramps, Diaper Rash, Baby Rash, Chapped Lips, Lip Dryness, Razor Burn, Chafing, Skin Chafing, Hot Flashes, Night Sweats, Menopause Symptoms, Water Retention, Ankle Swelling, Foot Swelling, Eye Strain, Eye Fatigue, Screen Fatigue, Dry Mouth, Mouth Dryness, Nosebleed, Tinnitus, Ringing in Ears, Cradle Cap, Colic, Muscle Spasms, Neck Pain, Shoulder Pain, Knee Pain, Wrist Pain, Foot Pain, Hip Pain, Sciatica, Psoriasis, Rosacea, Skin Redness, Bruise, Sprains, Minor Sprain, Ankle Pain

### Modify
- Backend: Add new medicines with comprehensive symptom arrays

### Remove
- Nothing

## Implementation Plan
1. Add ~20 new OTC medicine entries to Motoko backend covering the missing symptom categories above
2. Backend deploy will automatically expose new symptoms via `getAllSymptoms()`
