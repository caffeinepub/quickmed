# QuickMed

## Current State
SymptomFormPage has a hardcoded symptom list from the backend plus a custom symptom input (text field + plus button). The backend covers ~30 symptoms across 20 medicines.

## Requested Changes (Diff)

### Add
- Comprehensive symptom coverage in backend: ~60+ symptoms across new and existing medicines
- New OTC medicines: Miralax (Constipation), Unisom (Insomnia), Benadryl Cream (Skin Rash), Orajel (Toothache), Midol (Menstrual Cramps), Debrox (Earache), Visine (Eye Redness), Refresh Tears (Dry Eyes), Preparation H (Hemorrhoids), Lotrimin (Athlete's Foot), Head & Shoulders (Dandruff), Clearasil (Acne), Abreva (Cold Sores), Dramamine (Motion Sickness), Pepto-Bismol Kids (Vomiting), Maalox (Indigestion), Excedrin Migraine (Migraine), Sunburn cream, etc.

### Modify
- Backend: Expand symptom arrays on existing medicines; add new medicines
- Frontend SymptomFormPage: Remove custom symptom input field, Plus icon, addCustomSymptom logic, customSymptoms state, removeCustomSymptom logic. Keep only the predefined symptom pills.

### Remove
- Custom symptom input UI (text input + plus button)
- customSymptoms state and related logic
- Plus and X imports if no longer needed

## Implementation Plan
1. Update backend main.mo with expanded medicines and symptom coverage
2. Update SymptomFormPage.tsx to remove all custom symptom logic and UI
