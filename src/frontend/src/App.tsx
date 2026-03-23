import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Checkbox } from "@/components/ui/checkbox";
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
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { Textarea } from "@/components/ui/textarea";
import {
  Activity,
  AlertTriangle,
  ChevronRight,
  Clock,
  Heart,
  Info,
  Loader2,
  Pill,
  ShieldCheck,
  XCircle,
} from "lucide-react";
import { AnimatePresence, motion } from "motion/react";
import { useRef, useState } from "react";
import { useActor } from "./hooks/useActor";

import { type OTCMedicine, SafetyLevel } from "./backend.d";

// ─── Constants ────────────────────────────────────────────────────────────────

const SYMPTOMS = [
  "Headache",
  "Fever",
  "Cold",
  "Cough",
  "Sore Throat",
  "Nasal Congestion",
  "Body Aches",
  "Nausea",
  "Stomach Upset",
  "Diarrhea",
];

const ALLERGIES = ["None", "Aspirin", "Ibuprofen", "Penicillin", "Sulfa"];

// ─── Header ──────────────────────────────────────────────────────────────────

function Header({ onStartClick }: { onStartClick: () => void }) {
  const [mobileOpen, setMobileOpen] = useState(false);

  const scrollTo = (id: string) => {
    document.getElementById(id)?.scrollIntoView({ behavior: "smooth" });
    setMobileOpen(false);
  };

  const navLinks: [string, string][] = [
    ["Symptom Checker", "symptom-checker"],
    ["How it Works", "how-it-works"],
    ["About", "about"],
    ["Contact", "contact"],
  ];

  return (
    <header className="sticky top-0 z-50 bg-background border-b border-border shadow-xs">
      <div className="max-w-6xl mx-auto px-4 sm:px-6 h-16 flex items-center justify-between">
        {/* Logo */}
        <div className="flex items-center gap-2">
          <div className="w-8 h-8 rounded-lg bg-primary flex items-center justify-center">
            <svg
              width="18"
              height="18"
              viewBox="0 0 18 18"
              fill="none"
              aria-hidden="true"
              focusable="false"
            >
              <path
                d="M9 2C9 2 4 4.5 4 8.5C4 11.5 6.5 14 9 16C11.5 14 14 11.5 14 8.5C14 4.5 9 2 9 2Z"
                fill="white"
                fillOpacity="0.9"
              />
              <rect x="8" y="6" width="2" height="6" rx="1" fill="white" />
              <rect x="6" y="8" width="6" height="2" rx="1" fill="white" />
            </svg>
          </div>
          <span className="font-extrabold text-xl text-foreground tracking-tight">
            QuickMed
          </span>
        </div>

        {/* Desktop nav */}
        <nav className="hidden md:flex items-center gap-6">
          {navLinks.map(([label, id]) => (
            <button
              key={id}
              type="button"
              onClick={() => scrollTo(id)}
              className="text-sm font-medium text-muted-foreground hover:text-foreground transition-colors"
              data-ocid={`nav.${id}.link`}
            >
              {label}
            </button>
          ))}
        </nav>

        <div className="flex items-center gap-3">
          <Button
            onClick={onStartClick}
            className="hidden md:flex bg-primary hover:bg-primary-dark text-primary-foreground rounded-full px-5 text-sm font-semibold shadow-sm"
            data-ocid="nav.start_tool.button"
          >
            Start Tool
          </Button>
          {/* Mobile hamburger */}
          <button
            type="button"
            className="md:hidden p-2 rounded-md hover:bg-accent"
            onClick={() => setMobileOpen((v) => !v)}
            aria-label="Toggle menu"
          >
            <div className="w-5 h-0.5 bg-foreground mb-1" />
            <div className="w-5 h-0.5 bg-foreground mb-1" />
            <div className="w-5 h-0.5 bg-foreground" />
          </button>
        </div>
      </div>

      {/* Mobile menu */}
      <AnimatePresence>
        {mobileOpen && (
          <motion.div
            initial={{ height: 0, opacity: 0 }}
            animate={{ height: "auto", opacity: 1 }}
            exit={{ height: 0, opacity: 0 }}
            className="md:hidden border-t border-border bg-background overflow-hidden"
          >
            <div className="px-4 py-3 flex flex-col gap-3">
              {navLinks.map(([label, id]) => (
                <button
                  key={id}
                  type="button"
                  onClick={() => scrollTo(id)}
                  className="text-sm font-medium text-foreground text-left py-1"
                >
                  {label}
                </button>
              ))}
              <Button
                onClick={() => {
                  onStartClick();
                  setMobileOpen(false);
                }}
                className="bg-primary hover:bg-primary-dark text-primary-foreground rounded-full text-sm font-semibold"
              >
                Start Tool
              </Button>
            </div>
          </motion.div>
        )}
      </AnimatePresence>
    </header>
  );
}

// ─── Hero ─────────────────────────────────────────────────────────────────────

function Hero({ onStartClick }: { onStartClick: () => void }) {
  return (
    <section className="bg-background py-16 md:py-24">
      <div className="max-w-6xl mx-auto px-4 sm:px-6 grid md:grid-cols-2 gap-12 items-center">
        {/* Left */}
        <motion.div
          initial={{ opacity: 0, y: 24 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5 }}
        >
          <span className="inline-flex items-center gap-1.5 text-xs font-semibold uppercase tracking-widest text-primary bg-secondary px-3 py-1 rounded-full mb-4">
            <ShieldCheck className="w-3.5 h-3.5" />
            Safe OTC Guidance
          </span>
          <h1 className="text-4xl sm:text-5xl font-extrabold text-foreground leading-tight mb-5">
            Your Quick Guide to{" "}
            <span className="text-primary">OTC Medicine</span>
          </h1>
          <p className="text-base text-muted-foreground leading-relaxed mb-3">
            Select your symptoms, share basic health details, and instantly find
            over-the-counter medicines that are safe for you.
          </p>
          <p className="text-sm text-muted-foreground mb-8 p-3 bg-secondary border border-border rounded-lg">
            ⚕️ <strong>Disclaimer:</strong> QuickMed is for informational
            purposes only. Always consult a doctor or pharmacist before taking
            any medication.
          </p>
          <Button
            onClick={onStartClick}
            size="lg"
            className="bg-primary hover:bg-primary-dark text-primary-foreground rounded-full px-8 font-bold uppercase tracking-wide text-sm shadow-card"
            data-ocid="hero.start_check.button"
          >
            Start Your Symptom Check
            <ChevronRight className="w-4 h-4 ml-1" />
          </Button>
        </motion.div>

        {/* Right: SVG illustration */}
        <motion.div
          initial={{ opacity: 0, scale: 0.92 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ duration: 0.6, delay: 0.15 }}
          className="flex justify-center"
        >
          <svg
            width="400"
            height="360"
            viewBox="0 0 400 360"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
            className="w-full max-w-sm"
            aria-hidden="true"
            focusable="false"
          >
            <circle cx="200" cy="180" r="160" fill="oklch(0.95 0.03 218)" />
            <rect
              x="100"
              y="155"
              width="120"
              height="50"
              rx="25"
              fill="white"
              stroke="oklch(0.55 0.10 216)"
              strokeWidth="3"
            />
            <rect
              x="160"
              y="155"
              width="60"
              height="50"
              rx="0"
              fill="oklch(0.55 0.10 216)"
              opacity="0.15"
            />
            <rect
              x="160"
              y="155"
              width="40"
              height="50"
              rx="0"
              fill="oklch(0.55 0.10 216)"
              opacity="0.6"
            />
            <path
              d="M230 100 C230 90, 218 82, 210 90 C202 82, 190 90, 190 100 C190 115 210 130 210 130 C210 130 230 115 230 100Z"
              fill="oklch(0.55 0.10 216)"
              opacity="0.85"
            />
            <rect
              x="255"
              y="195"
              width="50"
              height="14"
              rx="7"
              fill="oklch(0.43 0.09 218)"
            />
            <rect
              x="275"
              y="175"
              width="14"
              height="50"
              rx="7"
              fill="oklch(0.43 0.09 218)"
            />
            <ellipse
              cx="145"
              cy="240"
              rx="20"
              ry="10"
              fill="white"
              stroke="oklch(0.55 0.10 216)"
              strokeWidth="2"
            />
            <ellipse
              cx="270"
              cy="140"
              rx="15"
              ry="8"
              fill="oklch(0.55 0.10 216)"
              opacity="0.3"
            />
            <circle
              cx="130"
              cy="120"
              r="6"
              fill="oklch(0.55 0.10 216)"
              opacity="0.2"
            />
            <circle
              cx="320"
              cy="220"
              r="8"
              fill="oklch(0.55 0.10 216)"
              opacity="0.2"
            />
            <circle
              cx="300"
              cy="260"
              r="5"
              fill="oklch(0.43 0.09 218)"
              opacity="0.3"
            />
          </svg>
        </motion.div>
      </div>
    </section>
  );
}

// ─── Safety Badge ─────────────────────────────────────────────────────────────

function SafetyBadge({ level }: { level: SafetyLevel }) {
  if (level === SafetyLevel.safe) {
    return (
      <Badge className="bg-safe-bg text-safe-text border-0 flex items-center gap-1 whitespace-nowrap">
        <ShieldCheck className="w-3 h-3" /> Safe
      </Badge>
    );
  }
  if (level === SafetyLevel.caution) {
    return (
      <Badge className="bg-caution-bg text-caution-text border-0 flex items-center gap-1 whitespace-nowrap">
        <AlertTriangle className="w-3 h-3" /> Caution
      </Badge>
    );
  }
  return (
    <Badge className="bg-avoid-bg text-avoid-text border-0 flex items-center gap-1 whitespace-nowrap">
      <XCircle className="w-3 h-3" /> Avoid
    </Badge>
  );
}

// ─── Symptom Form ─────────────────────────────────────────────────────────────

function SymptomForm({
  onResults,
}: {
  onResults: (medicines: OTCMedicine[]) => void;
}) {
  const [selectedSymptoms, setSelectedSymptoms] = useState<string[]>([]);
  const [age, setAge] = useState("");
  const [pregnancy, setPregnancy] = useState("N/A");
  const [selectedAllergies, setSelectedAllergies] = useState<string[]>([
    "None",
  ]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");
  const { actor } = useActor();

  const toggleSymptom = (s: string) => {
    setSelectedSymptoms((prev) =>
      prev.includes(s) ? prev.filter((x) => x !== s) : [...prev, s],
    );
  };

  const toggleAllergy = (a: string) => {
    if (a === "None") {
      setSelectedAllergies(["None"]);
      return;
    }
    setSelectedAllergies((prev) => {
      const without = prev.filter((x) => x !== "None");
      return without.includes(a)
        ? without.filter((x) => x !== a) || ["None"]
        : [...without, a];
    });
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");
    if (selectedSymptoms.length === 0) {
      setError("Please select at least one symptom.");
      return;
    }
    if (!age || Number(age) < 0 || Number(age) > 120) {
      setError("Please enter a valid age (0–120).");
      return;
    }
    setLoading(true);
    try {
      const allergiesInput = selectedAllergies.includes("None")
        ? []
        : selectedAllergies;
      const pregnancyStatus = pregnancy === "Yes" ? "pregnant" : "not_pregnant";
      if (!actor) throw new Error("Backend not ready");
      const results = await actor.getRecommendations(
        selectedSymptoms,
        BigInt(age),
        pregnancyStatus,
        allergiesInput,
      );
      onResults(results);
    } catch (err) {
      setError("Failed to fetch recommendations. Please try again.");
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  return (
    <section id="symptom-checker" className="bg-section-blue py-16">
      <div className="max-w-3xl mx-auto px-4 sm:px-6">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.5 }}
          className="text-center mb-8"
        >
          <h2 className="text-3xl font-extrabold text-foreground mb-2">
            Describe Your Symptoms
          </h2>
          <p className="text-muted-foreground text-sm">
            Answer a few quick questions to get personalised OTC medicine
            guidance.
          </p>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 24 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.5, delay: 0.1 }}
          className="bg-card rounded-2xl shadow-card border border-border p-6 sm:p-8"
        >
          <form onSubmit={handleSubmit} noValidate>
            {/* Step 1: Symptoms */}
            <div className="mb-7">
              <div className="flex items-center gap-2 mb-4">
                <span className="w-6 h-6 rounded-full bg-primary text-primary-foreground text-xs font-bold flex items-center justify-center">
                  1
                </span>
                <h3 className="font-bold text-base text-foreground">
                  Select Your Symptoms
                </h3>
              </div>
              <div
                className="grid grid-cols-2 sm:grid-cols-3 gap-3"
                data-ocid="symptoms.list"
              >
                {SYMPTOMS.map((symptom, i) => {
                  const symptomId = `symptom-${symptom.toLowerCase().replace(/\s+/g, "-")}`;
                  return (
                    <div
                      key={symptom}
                      className={`flex items-center gap-2.5 p-3 rounded-lg border cursor-pointer transition-all text-sm font-medium ${
                        selectedSymptoms.includes(symptom)
                          ? "border-primary bg-secondary text-foreground"
                          : "border-border bg-background text-muted-foreground hover:border-primary/50"
                      }`}
                      data-ocid={`symptoms.checkbox.${i + 1}`}
                    >
                      <Checkbox
                        id={symptomId}
                        checked={selectedSymptoms.includes(symptom)}
                        onCheckedChange={() => toggleSymptom(symptom)}
                        className="border-border data-[state=checked]:bg-primary data-[state=checked]:border-primary"
                      />
                      <Label
                        htmlFor={symptomId}
                        className="cursor-pointer font-medium text-sm"
                      >
                        {symptom}
                      </Label>
                    </div>
                  );
                })}
              </div>
            </div>

            {/* Step 2: Patient Details */}
            <div className="mb-7">
              <div className="flex items-center gap-2 mb-4">
                <span className="w-6 h-6 rounded-full bg-primary text-primary-foreground text-xs font-bold flex items-center justify-center">
                  2
                </span>
                <h3 className="font-bold text-base text-foreground">
                  Patient Details
                </h3>
              </div>
              <div className="grid sm:grid-cols-2 gap-4 mb-4">
                <div>
                  <Label
                    htmlFor="age"
                    className="text-sm font-medium text-foreground mb-1.5 block"
                  >
                    Age
                  </Label>
                  <Input
                    id="age"
                    type="number"
                    min="0"
                    max="120"
                    placeholder="Enter your age"
                    value={age}
                    onChange={(e) => setAge(e.target.value)}
                    className="border-border focus:ring-primary"
                    data-ocid="patient.age.input"
                  />
                </div>
                <div>
                  <Label
                    htmlFor="pregnancy-select"
                    className="text-sm font-medium text-foreground mb-1.5 block"
                  >
                    Pregnancy / Lactation Status
                  </Label>
                  <Select value={pregnancy} onValueChange={setPregnancy}>
                    <SelectTrigger
                      id="pregnancy-select"
                      className="border-border"
                      data-ocid="patient.pregnancy.select"
                    >
                      <SelectValue />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="N/A">N/A</SelectItem>
                      <SelectItem value="Yes">Yes</SelectItem>
                      <SelectItem value="No">No</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
              </div>

              <div>
                <p className="text-sm font-medium text-foreground mb-2">
                  Known Allergies
                </p>
                <div className="flex flex-wrap gap-3">
                  {ALLERGIES.map((allergy, i) => {
                    const allergyId = `allergy-${allergy.toLowerCase()}`;
                    return (
                      <div
                        key={allergy}
                        className={`flex items-center gap-2 px-3 py-2 rounded-lg border cursor-pointer transition-all text-sm font-medium ${
                          selectedAllergies.includes(allergy)
                            ? "border-primary bg-secondary text-foreground"
                            : "border-border bg-background text-muted-foreground hover:border-primary/50"
                        }`}
                        data-ocid={`allergies.checkbox.${i + 1}`}
                      >
                        <Checkbox
                          id={allergyId}
                          checked={selectedAllergies.includes(allergy)}
                          onCheckedChange={() => toggleAllergy(allergy)}
                          className="border-border data-[state=checked]:bg-primary data-[state=checked]:border-primary"
                        />
                        <Label
                          htmlFor={allergyId}
                          className="cursor-pointer font-medium text-sm"
                        >
                          {allergy}
                        </Label>
                      </div>
                    );
                  })}
                </div>
              </div>
            </div>

            {/* Error */}
            <AnimatePresence>
              {error && (
                <motion.p
                  initial={{ opacity: 0, y: -8 }}
                  animate={{ opacity: 1, y: 0 }}
                  exit={{ opacity: 0 }}
                  className="text-sm text-destructive mb-4 p-3 bg-avoid-bg rounded-lg"
                  data-ocid="form.error_state"
                >
                  {error}
                </motion.p>
              )}
            </AnimatePresence>

            <Button
              type="submit"
              disabled={loading}
              className="w-full bg-primary hover:bg-primary-dark text-primary-foreground font-bold uppercase tracking-widest text-sm rounded-xl h-12 shadow-card"
              data-ocid="form.submit_button"
            >
              {loading ? (
                <>
                  <Loader2 className="w-4 h-4 mr-2 animate-spin" />
                  Finding Medicines…
                </>
              ) : (
                "Get Recommendations"
              )}
            </Button>

            <p className="text-xs text-muted-foreground text-center mt-3">
              ⚕️ For guidance only. Always consult a healthcare professional
              before taking medication.
            </p>
          </form>
        </motion.div>
      </div>
    </section>
  );
}

// ─── Results ──────────────────────────────────────────────────────────────────

function Results({ medicines }: { medicines: OTCMedicine[] | null }) {
  if (medicines === null) return null;

  const rowBg = (level: SafetyLevel) => {
    if (level === SafetyLevel.safe) return "bg-safe-bg";
    if (level === SafetyLevel.caution) return "bg-caution-bg";
    return "bg-avoid-bg";
  };

  return (
    <section className="bg-section-blue pb-16">
      <div className="max-w-5xl mx-auto px-4 sm:px-6">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.45 }}
        >
          <h2 className="text-2xl font-extrabold text-foreground mb-5 text-center">
            Results: Recommended Medicines
          </h2>

          {medicines.length === 0 ? (
            <div
              className="bg-card rounded-2xl border border-border p-10 text-center shadow-card"
              data-ocid="results.empty_state"
            >
              <Info className="w-10 h-10 mx-auto text-primary opacity-50 mb-3" />
              <p className="text-foreground font-semibold mb-1">
                No matching medicines found
              </p>
              <p className="text-sm text-muted-foreground">
                Try adjusting your symptoms or patient details.
              </p>
            </div>
          ) : (
            <div
              className="bg-card rounded-2xl border border-border shadow-card overflow-hidden"
              data-ocid="results.table"
            >
              {/* Desktop table */}
              <div className="hidden md:block overflow-x-auto">
                <Table>
                  <TableHeader>
                    <TableRow className="bg-primary hover:bg-primary">
                      <TableHead className="text-primary-foreground font-bold">
                        Product
                      </TableHead>
                      <TableHead className="text-primary-foreground font-bold">
                        Treats
                      </TableHead>
                      <TableHead className="text-primary-foreground font-bold">
                        Dosage / Notes
                      </TableHead>
                      <TableHead className="text-primary-foreground font-bold">
                        Warnings
                      </TableHead>
                      <TableHead className="text-primary-foreground font-bold">
                        Safety
                      </TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {medicines.map((med, i) => (
                      <TableRow
                        key={`${med.name}-${med.brandName}`}
                        className={`${rowBg(med.safetyLevel)} hover:opacity-90 border-border`}
                        data-ocid={`results.row.${i + 1}`}
                      >
                        <TableCell>
                          <div className="font-semibold text-foreground text-sm">
                            {med.brandName}
                          </div>
                          <div className="text-xs text-muted-foreground">
                            {med.name}
                          </div>
                        </TableCell>
                        <TableCell className="text-sm text-foreground">
                          {med.symptoms.join(", ")}
                        </TableCell>
                        <TableCell className="text-sm text-foreground max-w-[200px]">
                          {med.dosageInstructions}
                        </TableCell>
                        <TableCell className="text-sm text-foreground max-w-[180px]">
                          {med.warnings || "—"}
                        </TableCell>
                        <TableCell>
                          <SafetyBadge level={med.safetyLevel} />
                        </TableCell>
                      </TableRow>
                    ))}
                  </TableBody>
                </Table>
              </div>

              {/* Mobile cards */}
              <div className="md:hidden divide-y divide-border">
                {medicines.map((med, i) => (
                  <div
                    key={`mobile-${med.name}-${med.brandName}`}
                    className={`${rowBg(med.safetyLevel)} p-4`}
                    data-ocid={`results.item.${i + 1}`}
                  >
                    <div className="flex justify-between items-start mb-2">
                      <div>
                        <div className="font-bold text-foreground">
                          {med.brandName}
                        </div>
                        <div className="text-xs text-muted-foreground">
                          {med.name}
                        </div>
                      </div>
                      <SafetyBadge level={med.safetyLevel} />
                    </div>
                    <div className="text-xs text-muted-foreground mb-1">
                      <span className="font-semibold text-foreground">
                        Treats:
                      </span>{" "}
                      {med.symptoms.join(", ")}
                    </div>
                    <div className="text-xs text-muted-foreground mb-1">
                      <span className="font-semibold text-foreground">
                        Dosage:
                      </span>{" "}
                      {med.dosageInstructions}
                    </div>
                    {med.warnings && (
                      <div className="text-xs text-muted-foreground">
                        <span className="font-semibold text-foreground">
                          Warnings:
                        </span>{" "}
                        {med.warnings}
                      </div>
                    )}
                  </div>
                ))}
              </div>
            </div>
          )}

          <div className="mt-4 p-4 bg-card border border-border rounded-xl text-center shadow-xs">
            <p className="text-sm text-muted-foreground">
              ⚕️ <strong>QuickMed is for guidance only.</strong> Always consult a
              doctor if symptoms persist or worsen.
            </p>
          </div>
        </motion.div>
      </div>
    </section>
  );
}

// ─── Education ────────────────────────────────────────────────────────────────

const educationCards = [
  {
    icon: <Pill className="w-6 h-6 text-primary" />,
    title: "Tips for Safe OTC Use",
    points: [
      "Always read the full label before use.",
      "Never exceed the recommended dose or duration.",
      "Inform your pharmacist of all medicines you take.",
      "Store medicines at room temperature, away from light.",
      "Check expiry dates before taking any medication.",
    ],
  },
  {
    icon: <Clock className="w-6 h-6 text-primary" />,
    title: "When to See a Doctor?",
    points: [
      "Symptoms last more than 7–10 days.",
      "Fever above 39°C (102°F) in adults.",
      "Difficulty breathing or chest tightness.",
      "Severe headache, stiff neck, or confusion.",
      "Symptoms rapidly worsen after initial improvement.",
    ],
  },
  {
    icon: <AlertTriangle className="w-6 h-6 text-primary" />,
    title: "Common OTC Warnings",
    points: [
      "Avoid alcohol with pain relievers and antihistamines.",
      "NSAIDs (e.g. Ibuprofen) can affect kidney and stomach health.",
      "Antihistamines may cause drowsiness — avoid driving.",
      "Do not give adult OTC medicines to children without guidance.",
      "Some products contain multiple active ingredients.",
    ],
  },
];

function EducationSection() {
  return (
    <section id="how-it-works" className="bg-background py-16">
      <div className="max-w-6xl mx-auto px-4 sm:px-6">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.5 }}
          className="text-center mb-10"
        >
          <h2 className="text-3xl font-extrabold text-foreground mb-2">
            OTC Medicine Guidance
          </h2>
          <p className="text-muted-foreground text-sm">
            Everything you need to use over-the-counter medicines safely.
          </p>
        </motion.div>
        <div className="grid md:grid-cols-3 gap-6">
          {educationCards.map((card, i) => (
            <motion.div
              key={card.title}
              initial={{ opacity: 0, y: 24 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.4, delay: i * 0.1 }}
              className="bg-card border border-border rounded-2xl p-6 shadow-card"
              data-ocid={`education.card.${i + 1}`}
            >
              <div className="w-11 h-11 rounded-xl bg-secondary flex items-center justify-center mb-4">
                {card.icon}
              </div>
              <h3 className="font-bold text-base text-foreground mb-3">
                {card.title}
              </h3>
              <ul className="space-y-2">
                {card.points.map((point) => (
                  <li
                    key={point}
                    className="flex gap-2 text-sm text-muted-foreground"
                  >
                    <span className="mt-1 w-1.5 h-1.5 rounded-full bg-primary flex-shrink-0" />
                    {point}
                  </li>
                ))}
              </ul>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  );
}

// ─── About ────────────────────────────────────────────────────────────────────

function AboutSection() {
  const [contactName, setContactName] = useState("");
  const [contactMessage, setContactMessage] = useState("");
  const [contactSuccess, setContactSuccess] = useState(false);

  const handleContactSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setContactSuccess(true);
    setContactName("");
    setContactMessage("");
    setTimeout(() => setContactSuccess(false), 4000);
  };

  return (
    <section id="about" className="bg-section-blue py-16">
      <div className="max-w-5xl mx-auto px-4 sm:px-6 grid md:grid-cols-2 gap-10">
        {/* About */}
        <motion.div
          initial={{ opacity: 0, x: -20 }}
          whileInView={{ opacity: 1, x: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.5 }}
        >
          <div className="flex items-center gap-2 mb-4">
            <Activity className="w-5 h-5 text-primary" />
            <h2 className="text-2xl font-extrabold text-foreground">
              About QuickMed
            </h2>
          </div>
          <p className="text-sm text-muted-foreground leading-relaxed mb-4">
            QuickMed is a free, self-service health information tool designed to
            help you identify over-the-counter medicines suitable for common
            symptoms — based on your age, allergy profile, and pregnancy status.
          </p>
          <p className="text-sm text-muted-foreground leading-relaxed mb-4">
            Our database is reviewed periodically to ensure accuracy. We do not
            store any personal health data you enter.
          </p>
          <div
            className="p-4 bg-card border border-border rounded-xl text-sm text-muted-foreground"
            data-ocid="about.disclaimer.panel"
          >
            <strong className="text-foreground">Legal Disclaimer:</strong>{" "}
            QuickMed provides general health information only and does not
            constitute medical advice, diagnosis, or treatment. Always seek the
            advice of a qualified healthcare provider with any questions you may
            have regarding a medical condition. Never disregard professional
            medical advice because of something you have read on QuickMed.
          </div>
        </motion.div>

        {/* Contact */}
        <motion.div
          id="contact"
          initial={{ opacity: 0, x: 20 }}
          whileInView={{ opacity: 1, x: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.5 }}
          className="bg-card border border-border rounded-2xl p-6 shadow-card"
        >
          <h3 className="font-bold text-lg text-foreground mb-4">
            Send Feedback
          </h3>
          <form onSubmit={handleContactSubmit} className="space-y-4">
            <div>
              <Label
                htmlFor="contact-name"
                className="text-sm font-medium text-foreground mb-1.5 block"
              >
                Your Name
              </Label>
              <Input
                id="contact-name"
                placeholder="Jane Smith"
                value={contactName}
                onChange={(e) => setContactName(e.target.value)}
                required
                className="border-border"
                data-ocid="contact.name.input"
              />
            </div>
            <div>
              <Label
                htmlFor="contact-message"
                className="text-sm font-medium text-foreground mb-1.5 block"
              >
                Message
              </Label>
              <Textarea
                id="contact-message"
                placeholder="Your feedback or question…"
                value={contactMessage}
                onChange={(e) => setContactMessage(e.target.value)}
                required
                rows={4}
                className="border-border resize-none"
                data-ocid="contact.message.textarea"
              />
            </div>
            <AnimatePresence>
              {contactSuccess && (
                <motion.p
                  initial={{ opacity: 0, y: -6 }}
                  animate={{ opacity: 1, y: 0 }}
                  exit={{ opacity: 0 }}
                  className="text-sm text-safe-text bg-safe-bg rounded-lg p-3"
                  data-ocid="contact.success_state"
                >
                  ✅ Thank you! Your message has been received.
                </motion.p>
              )}
            </AnimatePresence>
            <Button
              type="submit"
              className="w-full bg-primary hover:bg-primary-dark text-primary-foreground font-semibold rounded-xl"
              data-ocid="contact.submit_button"
            >
              Send Message
            </Button>
          </form>
        </motion.div>
      </div>
    </section>
  );
}

// ─── Footer ───────────────────────────────────────────────────────────────────

function Footer() {
  const year = new Date().getFullYear();
  const hostname =
    typeof window !== "undefined" ? window.location.hostname : "";
  const caffeineUrl = `https://caffeine.ai?utm_source=caffeine-footer&utm_medium=referral&utm_content=${encodeURIComponent(hostname)}`;

  const navLinks: [string, string][] = [
    ["Symptom Checker", "symptom-checker"],
    ["How it Works", "how-it-works"],
    ["About", "about"],
    ["Contact", "contact"],
  ];

  return (
    <footer className="bg-section-blue border-t border-border">
      <div className="max-w-6xl mx-auto px-4 sm:px-6 py-10 grid sm:grid-cols-3 gap-8">
        {/* Brand */}
        <div>
          <div className="flex items-center gap-2 mb-3">
            <div className="w-7 h-7 rounded-lg bg-primary flex items-center justify-center">
              <Heart className="w-4 h-4 text-primary-foreground" />
            </div>
            <span className="font-extrabold text-foreground">QuickMed</span>
          </div>
          <p className="text-xs text-muted-foreground leading-relaxed">
            Safe OTC medicine guidance at your fingertips. Always consult a
            doctor for medical advice.
          </p>
        </div>

        {/* Navigation */}
        <div>
          <h4 className="font-bold text-sm text-foreground mb-3">Navigation</h4>
          <ul className="space-y-2">
            {navLinks.map(([label, id]) => (
              <li key={id}>
                <button
                  type="button"
                  onClick={() =>
                    document
                      .getElementById(id)
                      ?.scrollIntoView({ behavior: "smooth" })
                  }
                  className="text-xs text-muted-foreground hover:text-foreground transition-colors"
                  data-ocid={`footer.${id}.link`}
                >
                  {label}
                </button>
              </li>
            ))}
          </ul>
        </div>

        {/* Disclaimer */}
        <div>
          <h4 className="font-bold text-sm text-foreground mb-3">Disclaimer</h4>
          <p className="text-xs text-muted-foreground leading-relaxed">
            QuickMed is for informational purposes only. It does not constitute
            medical advice. Always consult a licensed healthcare professional
            before taking any medication.
          </p>
        </div>
      </div>

      <div className="border-t border-border px-4 sm:px-6 py-4 text-center text-xs text-muted-foreground">
        QuickMed © {year} &nbsp;·&nbsp; Built with ❤️ using{" "}
        <a
          href={caffeineUrl}
          target="_blank"
          rel="noopener noreferrer"
          className="hover:text-foreground underline underline-offset-2"
        >
          caffeine.ai
        </a>
      </div>
    </footer>
  );
}

// ─── App ──────────────────────────────────────────────────────────────────────

export default function App() {
  const [results, setResults] = useState<OTCMedicine[] | null>(null);
  const formRef = useRef<HTMLDivElement>(null);
  const resultsRef = useRef<HTMLDivElement>(null);

  const scrollToForm = () => {
    document
      .getElementById("symptom-checker")
      ?.scrollIntoView({ behavior: "smooth" });
  };

  const handleResults = (medicines: OTCMedicine[]) => {
    setResults(medicines);
    setTimeout(() => {
      resultsRef.current?.scrollIntoView({
        behavior: "smooth",
        block: "start",
      });
    }, 100);
  };

  return (
    <div className="min-h-screen flex flex-col">
      <Header onStartClick={scrollToForm} />
      <main className="flex-1">
        <Hero onStartClick={scrollToForm} />
        <div ref={formRef}>
          <SymptomForm onResults={handleResults} />
        </div>
        <div ref={resultsRef}>
          <Results medicines={results} />
        </div>
        <EducationSection />
        <AboutSection />
      </main>
      <Footer />
    </div>
  );
}
