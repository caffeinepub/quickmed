import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import {
  AlertTriangle,
  ArrowLeft,
  CheckCircle,
  ChevronDown,
  ChevronUp,
  Info,
  Zap,
} from "lucide-react";
import { AnimatePresence, motion } from "motion/react";
import { useState } from "react";
import type { OTCMedicine } from "../backend.d";
import { SafetyLevel } from "../backend.d";
import type { FormData } from "./SymptomFormPage";

interface ResultsPageProps {
  medicines: OTCMedicine[];
  formData: FormData;
  onBack: () => void;
  onCheckInteractions: (medicines: OTCMedicine[]) => void;
}

function safetyConfig(level: SafetyLevel) {
  if (level === SafetyLevel.safe) {
    return {
      label: "Safe",
      bgClass: "bg-safe-bg",
      textClass: "text-safe-text",
      borderClass: "border-safe-text/20",
      icon: CheckCircle,
    };
  }
  if (level === SafetyLevel.caution) {
    return {
      label: "Caution",
      bgClass: "bg-caution-bg",
      textClass: "text-caution-text",
      borderClass: "border-caution-text/20",
      icon: AlertTriangle,
    };
  }
  return {
    label: "Avoid",
    bgClass: "bg-avoid-bg",
    textClass: "text-avoid-text",
    borderClass: "border-avoid-text/20",
    icon: AlertTriangle,
  };
}

function pregnancyLabel(status: string) {
  if (status === "pregnant") return "Pregnant";
  if (status === "breastfeeding") return "Breastfeeding";
  return null;
}

function MedicineCard({
  medicine,
  index,
}: { medicine: OTCMedicine; index: number }) {
  const [expanded, setExpanded] = useState(false);
  const sc = safetyConfig(medicine.safetyLevel);
  const Icon = sc.icon;

  return (
    <motion.div
      initial={{ opacity: 0, y: 16 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.35, delay: index * 0.07 }}
      className={`bg-card border rounded-xl shadow-xs overflow-hidden ${sc.borderClass}`}
      data-ocid={`results.item.${index + 1}`}
    >
      <div className="p-5">
        <div className="flex items-start justify-between gap-3 mb-3">
          <div>
            <h3 className="font-bold text-lg text-foreground">
              {medicine.name}
            </h3>
            {medicine.brandName && (
              <p className="text-sm text-muted-foreground">
                {medicine.brandName}
              </p>
            )}
          </div>
          <span
            className={`flex items-center gap-1.5 px-3 py-1 rounded-full text-sm font-semibold ${sc.bgClass} ${sc.textClass} border ${sc.borderClass} flex-shrink-0`}
          >
            <Icon className="w-3.5 h-3.5" />
            {sc.label}
          </span>
        </div>

        {/* Symptoms */}
        {medicine.symptoms.length > 0 && (
          <div className="flex flex-wrap gap-1.5 mb-3">
            {medicine.symptoms.map((s) => (
              <span
                key={s}
                className="px-2 py-0.5 bg-section-blue text-primary text-xs rounded-full border border-primary/20"
              >
                {s}
              </span>
            ))}
          </div>
        )}

        {/* Dosage */}
        <div className="bg-muted rounded-lg px-4 py-3 mb-3">
          <p className="text-xs text-muted-foreground font-semibold uppercase tracking-wide mb-1">
            Dosage
          </p>
          <p className="text-sm text-foreground">
            {medicine.dosageInstructions}
          </p>
        </div>

        {/* Warnings */}
        {medicine.warnings && (
          <div
            className={`flex items-start gap-2 px-4 py-3 rounded-lg mb-3 ${sc.bgClass} border ${sc.borderClass}`}
          >
            <AlertTriangle
              className={`w-4 h-4 ${sc.textClass} mt-0.5 flex-shrink-0`}
            />
            <p className={`text-sm ${sc.textClass}`}>{medicine.warnings}</p>
          </div>
        )}

        {/* Expand/collapse */}
        <button
          type="button"
          onClick={() => setExpanded((v) => !v)}
          className="flex items-center gap-1 text-sm text-primary hover:text-primary-dark font-medium"
          data-ocid={"results.toggle"}
        >
          {expanded ? (
            <>
              <ChevronUp className="w-4 h-4" /> Show less
            </>
          ) : (
            <>
              <ChevronDown className="w-4 h-4" /> See precautions & doctor
              advice
            </>
          )}
        </button>

        <AnimatePresence>
          {expanded && (
            <motion.div
              initial={{ height: 0, opacity: 0 }}
              animate={{ height: "auto", opacity: 1 }}
              exit={{ height: 0, opacity: 0 }}
              transition={{ duration: 0.25 }}
              className="overflow-hidden"
            >
              <div className="mt-4 space-y-3">
                {medicine.avoidIf && (
                  <div className="bg-avoid-bg border border-avoid-text/20 rounded-lg px-4 py-3">
                    <p className="text-xs font-semibold text-avoid-text uppercase tracking-wide mb-1">
                      Avoid If…
                    </p>
                    <p className="text-sm text-avoid-text">
                      {medicine.avoidIf}
                    </p>
                  </div>
                )}
                {medicine.consultDoctorIf && (
                  <div className="bg-caution-bg border border-caution-text/20 rounded-lg px-4 py-3">
                    <p className="text-xs font-semibold text-caution-text uppercase tracking-wide mb-1">
                      Consult Doctor If…
                    </p>
                    <p className="text-sm text-caution-text">
                      {medicine.consultDoctorIf}
                    </p>
                  </div>
                )}
                {medicine.allergyNotes.length > 0 && (
                  <div className="bg-section-blue border border-primary/20 rounded-lg px-4 py-3">
                    <p className="text-xs font-semibold text-primary uppercase tracking-wide mb-1">
                      Allergy Notes
                    </p>
                    <p className="text-sm text-foreground">
                      {medicine.allergyNotes.join(", ")}
                    </p>
                  </div>
                )}
              </div>
            </motion.div>
          )}
        </AnimatePresence>
      </div>
    </motion.div>
  );
}

export default function ResultsPage({
  medicines,
  formData,
  onBack,
  onCheckInteractions,
}: ResultsPageProps) {
  const preg = pregnancyLabel(formData.pregnancyStatus);

  return (
    <div className="min-h-screen flex flex-col">
      <header className="sticky top-0 z-20 bg-white/95 backdrop-blur border-b border-border px-4 py-3">
        <div className="max-w-3xl mx-auto flex items-center justify-between gap-3">
          <div className="flex items-center gap-3">
            <Button
              variant="ghost"
              size="sm"
              onClick={onBack}
              data-ocid="results.cancel_button"
            >
              <ArrowLeft className="w-4 h-4 mr-1" /> Back
            </Button>
            <h1 className="font-bold text-lg text-foreground">
              Recommended OTC Medicines
            </h1>
          </div>
          <Button
            variant="outline"
            size="sm"
            onClick={() => onCheckInteractions(medicines)}
            data-ocid="results.secondary_button"
          >
            <Zap className="w-4 h-4 mr-1" /> Interactions
          </Button>
        </div>
      </header>

      <main className="flex-1 px-4 py-6 pb-24">
        <div className="max-w-3xl mx-auto space-y-6">
          {/* Summary */}
          <div className="bg-section-blue border border-primary/20 rounded-xl px-5 py-4">
            <p className="text-xs font-semibold text-primary uppercase tracking-wide mb-2">
              Your Profile
            </p>
            <div className="flex flex-wrap gap-2">
              <Badge variant="secondary">Age: {formData.age}</Badge>
              {formData.symptoms.map((s) => (
                <Badge key={s} variant="secondary">
                  {s}
                </Badge>
              ))}
              {preg && <Badge variant="secondary">{preg}</Badge>}
              {formData.allergies.map((a) => (
                <Badge
                  key={a}
                  variant="outline"
                  className="border-avoid-text/30 text-avoid-text bg-avoid-bg"
                >
                  Allergy: {a}
                </Badge>
              ))}
            </div>
          </div>

          {/* Results */}
          {medicines.length === 0 ? (
            <div className="text-center py-16" data-ocid="results.empty_state">
              <Info className="w-12 h-12 text-muted-foreground mx-auto mb-4" />
              <h3 className="font-semibold text-lg text-foreground mb-2">
                No medicines found
              </h3>
              <p className="text-muted-foreground text-sm max-w-sm mx-auto mb-4">
                No OTC medicines matched your profile. This may be due to your
                age, pregnancy status, or listed allergies.
              </p>
              <ul className="text-sm text-muted-foreground space-y-1">
                <li>• Try removing some allergy filters</li>
                <li>• Consider selecting fewer or different symptoms</li>
                <li>• Consult a healthcare professional directly</li>
              </ul>
            </div>
          ) : (
            <div className="space-y-4">
              <p className="text-sm text-muted-foreground">
                {medicines.length} medicine{medicines.length !== 1 ? "s" : ""}{" "}
                found
              </p>
              {medicines.map((m, i) => (
                <MedicineCard key={`${m.name}-${i}`} medicine={m} index={i} />
              ))}
            </div>
          )}

          {/* CTA */}
          {medicines.length > 0 && (
            <Button
              size="lg"
              variant="outline"
              className="w-full"
              onClick={() => onCheckInteractions(medicines)}
              data-ocid="results.primary_button"
            >
              <Zap className="w-4 h-4 mr-2" />
              Check Drug Interactions for These Medicines
            </Button>
          )}
        </div>
      </main>

      {/* Sticky disclaimer */}
      <div className="fixed bottom-0 left-0 right-0 z-30 bg-caution-bg border-t border-caution-text/20 px-4 py-3">
        <p className="text-xs text-center text-caution-text max-w-3xl mx-auto">
          ⚠️ This is guidance only — not a prescription. Consult a doctor if
          symptoms persist or worsen.
        </p>
      </div>
    </div>
  );
}
