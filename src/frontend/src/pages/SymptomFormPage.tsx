import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  AlertTriangle,
  ArrowLeft,
  Loader2,
  Plus,
  Search,
  X,
} from "lucide-react";
import { motion } from "motion/react";
import { useState } from "react";
import type { OTCMedicine } from "../backend.d";
import { useGetAllSymptoms, useGetRecommendations } from "../hooks/useQueries";

interface SymptomFormPageProps {
  onBack: () => void;
  onResults: (medicines: OTCMedicine[], formData: FormData) => void;
}

export interface FormData {
  symptoms: string[];
  age: number;
  gender: string;
  pregnancyStatus: string;
  allergies: string[];
}

export default function SymptomFormPage({
  onBack,
  onResults,
}: SymptomFormPageProps) {
  const { data: allSymptoms, isLoading: symptomsLoading } = useGetAllSymptoms();
  const getRecommendations = useGetRecommendations();

  const [selectedSymptoms, setSelectedSymptoms] = useState<string[]>([]);
  const [symptomSearch, setSymptomSearch] = useState("");
  const [age, setAge] = useState("");
  const [gender, setGender] = useState("");
  const [pregnancyStatus, setPregnancyStatus] = useState("not_pregnant");
  const [allergies, setAllergies] = useState<string[]>([]);
  const [allergyInput, setAllergyInput] = useState("");
  const [error, setError] = useState("");

  const toggleSymptom = (symptom: string) => {
    setSelectedSymptoms((prev) =>
      prev.includes(symptom)
        ? prev.filter((s) => s !== symptom)
        : [...prev, symptom],
    );
  };

  const addAllergy = () => {
    const trimmed = allergyInput.trim();
    if (trimmed && !allergies.includes(trimmed)) {
      setAllergies((prev) => [...prev, trimmed]);
    }
    setAllergyInput("");
  };

  const removeAllergy = (a: string) => {
    setAllergies((prev) => prev.filter((x) => x !== a));
  };

  const filteredSymptoms = (allSymptoms ?? []).filter((s) =>
    s.toLowerCase().includes(symptomSearch.toLowerCase()),
  );

  const canSubmit =
    selectedSymptoms.length > 0 && age.trim() !== "" && Number(age) > 0;

  const handleSubmit = async () => {
    if (!canSubmit) return;
    setError("");
    try {
      const medicines = await getRecommendations.mutateAsync({
        symptoms: selectedSymptoms,
        age: Number(age),
        pregnancyStatus,
        allergies,
      });
      onResults(medicines, {
        symptoms: selectedSymptoms,
        age: Number(age),
        gender,
        pregnancyStatus,
        allergies,
      });
    } catch {
      setError("Failed to fetch recommendations. Please try again.");
    }
  };

  return (
    <div className="min-h-screen flex flex-col">
      <header className="sticky top-0 z-20 bg-white/95 backdrop-blur border-b border-border px-4 py-3">
        <div className="max-w-3xl mx-auto flex items-center gap-3">
          <Button
            variant="ghost"
            size="sm"
            onClick={onBack}
            data-ocid="form.cancel_button"
          >
            <ArrowLeft className="w-4 h-4 mr-1" /> Back
          </Button>
          <h1 className="font-bold text-lg text-foreground">
            Tell Us Your Symptoms
          </h1>
        </div>
      </header>

      <main className="flex-1 px-4 py-8">
        <motion.div
          initial={{ opacity: 0, y: 16 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.4 }}
          className="max-w-3xl mx-auto space-y-8"
        >
          {/* Symptoms */}
          <section>
            <Label className="text-base font-semibold mb-3 block">
              Symptoms <span className="text-destructive">*</span>
            </Label>

            {/* Symptom search */}
            <div className="relative max-w-md mb-3">
              <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground pointer-events-none" />
              <Input
                placeholder="Search symptoms..."
                value={symptomSearch}
                onChange={(e) => setSymptomSearch(e.target.value)}
                className="pl-9"
                data-ocid="form.search_input"
              />
            </div>

            {symptomsLoading ? (
              <div
                className="flex items-center gap-2 text-muted-foreground"
                data-ocid="form.loading_state"
              >
                <Loader2 className="w-4 h-4 animate-spin" />
                <span className="text-sm">Loading symptoms...</span>
              </div>
            ) : (
              <div className="flex flex-wrap gap-2" data-ocid="form.panel">
                {filteredSymptoms.map((symptom) => (
                  <button
                    key={symptom}
                    type="button"
                    onClick={() => toggleSymptom(symptom)}
                    data-ocid="form.toggle"
                    className={`px-3 py-1.5 rounded-full text-sm font-medium border transition-all select-none ${
                      selectedSymptoms.includes(symptom)
                        ? "bg-primary text-primary-foreground border-primary shadow-xs"
                        : "bg-white text-foreground border-border hover:border-primary hover:bg-section-blue"
                    }`}
                  >
                    {symptom}
                  </button>
                ))}
                {filteredSymptoms.length === 0 && (
                  <p className="text-sm text-muted-foreground">
                    No symptoms match your search.
                  </p>
                )}
              </div>
            )}

            {selectedSymptoms.length === 0 && (
              <p className="text-xs text-muted-foreground mt-2">
                Select at least one symptom to continue.
              </p>
            )}
          </section>

          {/* Age */}
          <section>
            <Label
              htmlFor="age-input"
              className="text-base font-semibold mb-2 block"
            >
              Age <span className="text-destructive">*</span>
            </Label>
            <Input
              id="age-input"
              type="number"
              min={0}
              max={120}
              placeholder="Enter your age"
              value={age}
              onChange={(e) => setAge(e.target.value)}
              data-ocid="form.input"
              className="max-w-xs"
            />
          </section>

          {/* Gender */}
          <section>
            <Label className="text-base font-semibold mb-2 block">
              Gender{" "}
              <span className="text-muted-foreground text-sm font-normal">
                (optional)
              </span>
            </Label>
            <Select value={gender} onValueChange={setGender}>
              <SelectTrigger className="max-w-xs" data-ocid="form.select">
                <SelectValue placeholder="Select gender" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="male">Male</SelectItem>
                <SelectItem value="female">Female</SelectItem>
                <SelectItem value="other">Other</SelectItem>
                <SelectItem value="prefer_not">Prefer not to say</SelectItem>
              </SelectContent>
            </Select>
          </section>

          {/* Pregnancy Status */}
          <section>
            <Label className="text-base font-semibold mb-2 block">
              Pregnancy / Lactation Status
            </Label>
            <Select value={pregnancyStatus} onValueChange={setPregnancyStatus}>
              <SelectTrigger className="max-w-xs" data-ocid="form.select">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="not_pregnant">
                  Not pregnant / Not applicable
                </SelectItem>
                <SelectItem value="pregnant">Pregnant</SelectItem>
                <SelectItem value="breastfeeding">Breastfeeding</SelectItem>
              </SelectContent>
            </Select>
          </section>

          {/* Allergies */}
          <section>
            <Label className="text-base font-semibold mb-2 block">
              Known Allergies
            </Label>
            <div className="flex gap-2 max-w-md">
              <Input
                placeholder="e.g. Aspirin, Ibuprofen..."
                value={allergyInput}
                onChange={(e) => setAllergyInput(e.target.value)}
                onKeyDown={(e) => {
                  if (e.key === "Enter") {
                    e.preventDefault();
                    addAllergy();
                  }
                }}
                data-ocid="form.input"
              />
              <Button
                variant="outline"
                onClick={addAllergy}
                type="button"
                data-ocid="form.secondary_button"
              >
                <Plus className="w-4 h-4" />
              </Button>
            </div>
            {allergies.length > 0 && (
              <div className="flex flex-wrap gap-2 mt-3">
                {allergies.map((a) => (
                  <span
                    key={a}
                    className="flex items-center gap-1 px-3 py-1 bg-avoid-bg text-avoid-text border border-avoid-text/20 rounded-full text-sm"
                  >
                    {a}
                    <button
                      type="button"
                      onClick={() => removeAllergy(a)}
                      className="hover:opacity-70"
                    >
                      <X className="w-3 h-3" />
                    </button>
                  </span>
                ))}
              </div>
            )}
          </section>

          {/* Error */}
          {error && (
            <div
              className="flex items-center gap-2 bg-avoid-bg border border-avoid-text/20 rounded-lg px-4 py-3"
              data-ocid="form.error_state"
            >
              <AlertTriangle className="w-4 h-4 text-avoid-text flex-shrink-0" />
              <p className="text-sm text-avoid-text">{error}</p>
            </div>
          )}

          {/* Submit */}
          <Button
            size="lg"
            disabled={!canSubmit || getRecommendations.isPending}
            onClick={handleSubmit}
            data-ocid="form.submit_button"
            className="w-full sm:w-auto px-8"
          >
            {getRecommendations.isPending ? (
              <>
                <Loader2 className="w-4 h-4 mr-2 animate-spin" /> Finding
                Medicines...
              </>
            ) : (
              <>
                <Search className="w-4 h-4 mr-2" /> Find Safe OTC Medicines
              </>
            )}
          </Button>
        </motion.div>
      </main>

      {/* Footer disclaimer */}
      <footer className="px-4 py-4 border-t border-border">
        <p className="text-xs text-center text-muted-foreground max-w-3xl mx-auto">
          © {new Date().getFullYear()} QuickMed · OTC guidance only · Built with
          ❤️ using{" "}
          <a
            href={`https://caffeine.ai?utm_source=caffeine-footer&utm_medium=referral&utm_content=${encodeURIComponent(window.location.hostname)}`}
            target="_blank"
            rel="noopener noreferrer"
            className="underline hover:text-primary"
          >
            caffeine.ai
          </a>
        </p>
      </footer>
    </div>
  );
}
