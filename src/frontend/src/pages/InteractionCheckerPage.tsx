import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
  AlertTriangle,
  ArrowLeft,
  CheckCircle,
  Loader2,
  Plus,
  X,
  Zap,
} from "lucide-react";
import { AnimatePresence, motion } from "motion/react";
import { useState } from "react";
import type { Interaction, OTCMedicine } from "../backend.d";
import { Severity } from "../backend.d";
import { useCheckInteractions } from "../hooks/useQueries";

interface InteractionCheckerPageProps {
  initialMedicines?: OTCMedicine[];
  onBack: () => void;
}

function severityConfig(severity: Severity) {
  if (severity === Severity.mild) {
    return {
      label: "Mild",
      bgClass: "bg-safe-bg",
      textClass: "text-safe-text",
      borderClass: "border-safe-text/20",
    };
  }
  if (severity === Severity.moderate) {
    return {
      label: "Moderate",
      bgClass: "bg-caution-bg",
      textClass: "text-caution-text",
      borderClass: "border-caution-text/20",
    };
  }
  return {
    label: "Severe",
    bgClass: "bg-avoid-bg",
    textClass: "text-avoid-text",
    borderClass: "border-avoid-text/20",
  };
}

export default function InteractionCheckerPage({
  initialMedicines,
  onBack,
}: InteractionCheckerPageProps) {
  const checkInteractions = useCheckInteractions();
  const initialDrugs = initialMedicines?.map((m) => m.name) ?? [];
  const [drugs, setDrugs] = useState<string[]>(initialDrugs);
  const [inputValue, setInputValue] = useState("");
  const [interactions, setInteractions] = useState<Interaction[] | null>(null);
  const [error, setError] = useState("");

  const suggestions = initialMedicines
    ? initialMedicines.map((m) => m.name).filter((n) => !drugs.includes(n))
    : [];

  const addDrug = (name?: string) => {
    const trimmed = (name ?? inputValue).trim();
    if (trimmed && !drugs.includes(trimmed)) {
      setDrugs((prev) => [...prev, trimmed]);
    }
    setInputValue("");
  };

  const removeDrug = (d: string) => {
    setDrugs((prev) => prev.filter((x) => x !== d));
    setInteractions(null);
  };

  const handleCheck = async () => {
    if (drugs.length < 2) return;
    setError("");
    setInteractions(null);
    try {
      const result = await checkInteractions.mutateAsync(drugs);
      setInteractions(result);
    } catch {
      setError("Failed to check interactions. Please try again.");
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
            data-ocid="interactions.cancel_button"
          >
            <ArrowLeft className="w-4 h-4 mr-1" /> Back
          </Button>
          <h1 className="font-bold text-lg text-foreground">
            Drug Interaction Checker
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
          {/* Input */}
          <section>
            <Label className="text-base font-semibold mb-2 block">
              Add Drugs or Foods to Check
            </Label>
            <div className="flex gap-2">
              <Input
                placeholder="e.g. Ibuprofen, Alcohol, Grapefruit..."
                value={inputValue}
                onChange={(e) => setInputValue(e.target.value)}
                onKeyDown={(e) => {
                  if (e.key === "Enter") {
                    e.preventDefault();
                    addDrug();
                  }
                }}
                data-ocid="interactions.input"
              />
              <Button
                variant="outline"
                onClick={() => addDrug()}
                type="button"
                data-ocid="interactions.secondary_button"
              >
                <Plus className="w-4 h-4" />
              </Button>
            </div>

            {/* Suggestions from results */}
            {suggestions.length > 0 && (
              <div className="mt-3">
                <p className="text-xs text-muted-foreground mb-2">
                  From your results:
                </p>
                <div className="flex flex-wrap gap-2">
                  {suggestions.map((s) => (
                    <button
                      key={s}
                      type="button"
                      onClick={() => addDrug(s)}
                      className="px-3 py-1 bg-section-blue text-primary border border-primary/20 rounded-full text-sm hover:bg-primary hover:text-primary-foreground transition-colors"
                      data-ocid="interactions.toggle"
                    >
                      + {s}
                    </button>
                  ))}
                </div>
              </div>
            )}

            {/* Selected chips */}
            {drugs.length > 0 && (
              <div className="flex flex-wrap gap-2 mt-4">
                {drugs.map((d) => (
                  <span
                    key={d}
                    className="flex items-center gap-1 px-3 py-1 bg-primary text-primary-foreground rounded-full text-sm font-medium"
                  >
                    {d}
                    <button
                      type="button"
                      onClick={() => removeDrug(d)}
                      className="hover:opacity-70 ml-1"
                    >
                      <X className="w-3.5 h-3.5" />
                    </button>
                  </span>
                ))}
              </div>
            )}

            {drugs.length < 2 && (
              <p className="text-xs text-muted-foreground mt-2">
                Add at least 2 drugs or foods to check interactions.
              </p>
            )}
          </section>

          {/* Check button */}
          <Button
            size="lg"
            disabled={drugs.length < 2 || checkInteractions.isPending}
            onClick={handleCheck}
            data-ocid="interactions.submit_button"
            className="w-full sm:w-auto px-8"
          >
            {checkInteractions.isPending ? (
              <>
                <Loader2 className="w-4 h-4 mr-2 animate-spin" /> Checking...
              </>
            ) : (
              <>
                <Zap className="w-4 h-4 mr-2" /> Check Interactions
              </>
            )}
          </Button>

          {/* Error */}
          {error && (
            <div
              className="flex items-center gap-2 bg-avoid-bg border border-avoid-text/20 rounded-lg px-4 py-3"
              data-ocid="interactions.error_state"
            >
              <AlertTriangle className="w-4 h-4 text-avoid-text" />
              <p className="text-sm text-avoid-text">{error}</p>
            </div>
          )}

          {/* Results */}
          <AnimatePresence>
            {interactions !== null && (
              <motion.section
                initial={{ opacity: 0, y: 16 }}
                animate={{ opacity: 1, y: 0 }}
                exit={{ opacity: 0 }}
                transition={{ duration: 0.3 }}
              >
                <h2 className="text-lg font-bold text-foreground mb-4">
                  Interaction Results
                </h2>

                {interactions.length === 0 ? (
                  <div
                    className="flex items-center gap-3 bg-safe-bg border border-safe-text/20 rounded-xl px-5 py-4"
                    data-ocid="interactions.success_state"
                  >
                    <CheckCircle className="w-6 h-6 text-safe-text flex-shrink-0" />
                    <div>
                      <p className="font-semibold text-safe-text">
                        No Known Interactions Found
                      </p>
                      <p className="text-sm text-safe-text/80 mt-0.5">
                        No interactions detected between the selected
                        drugs/foods. Always read labels and consult a pharmacist
                        if unsure.
                      </p>
                    </div>
                  </div>
                ) : (
                  <div className="space-y-4">
                    <p className="text-sm text-muted-foreground">
                      {interactions.length} interaction
                      {interactions.length !== 1 ? "s" : ""} found
                    </p>
                    {interactions.map((interaction, i) => {
                      const sc = severityConfig(interaction.severity);
                      return (
                        <motion.div
                          key={`${interaction.drug1}-${interaction.drug2}-${i}`}
                          initial={{ opacity: 0, y: 12 }}
                          animate={{ opacity: 1, y: 0 }}
                          transition={{ delay: i * 0.07 }}
                          className={`bg-card border rounded-xl p-5 shadow-xs ${sc.borderClass}`}
                          data-ocid={`interactions.item.${i + 1}`}
                        >
                          <div className="flex items-start justify-between gap-3 mb-3">
                            <div className="font-semibold text-foreground">
                              <span>{interaction.drug1}</span>
                              <span className="text-muted-foreground mx-2">
                                ↔
                              </span>
                              <span>{interaction.drug2}</span>
                            </div>
                            <span
                              className={`px-3 py-1 rounded-full text-sm font-semibold flex-shrink-0 ${sc.bgClass} ${sc.textClass} border ${sc.borderClass}`}
                            >
                              {sc.label}
                            </span>
                          </div>
                          <p className="text-xs font-semibold text-muted-foreground uppercase tracking-wide mb-2">
                            {interaction.interactionType}
                          </p>
                          <p className="text-sm text-foreground leading-relaxed">
                            {interaction.explanation}
                          </p>
                        </motion.div>
                      );
                    })}
                  </div>
                )}
              </motion.section>
            )}
          </AnimatePresence>

          {/* Safety reminder */}
          <div className="flex items-start gap-3 bg-section-blue border border-primary/20 rounded-xl px-5 py-4">
            <AlertTriangle className="w-5 h-5 text-primary mt-0.5 flex-shrink-0" />
            <p className="text-sm text-foreground/80">
              <strong className="text-foreground">Reminder:</strong> This is
              guidance, not a prescription. Drug interaction databases may not
              include all interactions. Consult a pharmacist or doctor before
              combining medications.
            </p>
          </div>
        </motion.div>
      </main>

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
