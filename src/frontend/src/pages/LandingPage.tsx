import { Button } from "@/components/ui/button";
import {
  AlertTriangle,
  ExternalLink,
  Pill,
  Search,
  Shield,
  Zap,
} from "lucide-react";
import { motion } from "motion/react";

interface LandingPageProps {
  onStart: () => void;
}

const features = [
  {
    icon: Search,
    title: "Symptom Checker",
    desc: "Select your symptoms and get matched with safe OTC options tailored to your profile.",
    color: "text-primary",
    bg: "bg-section-blue",
  },
  {
    icon: Shield,
    title: "Smart Safety Filters",
    desc: "Age-based, pregnancy, and allergy filters ensure only appropriate medicines are shown.",
    color: "text-primary",
    bg: "bg-section-blue",
  },
  {
    icon: Zap,
    title: "Drug Interaction Checker",
    desc: "Check Drug–Drug and Drug–Food interactions with severity levels: Mild, Moderate, Severe.",
    color: "text-primary",
    bg: "bg-section-blue",
  },
  {
    icon: AlertTriangle,
    title: "Risk Alerts",
    desc: "Highlights unsafe combinations, flags high-risk conditions, and suggests when to see a doctor.",
    color: "text-primary",
    bg: "bg-section-blue",
  },
];

const sources = [
  {
    name: "U.S. FDA",
    full: "Food & Drug Administration",
    href: "https://www.fda.gov",
  },
  {
    name: "DailyMed",
    full: "NLM Drug Label Database",
    href: "https://dailymed.nlm.nih.gov",
  },
  {
    name: "DrugBank",
    full: "Drug Interaction Database",
    href: "https://www.drugbank.com",
  },
  {
    name: "WHO",
    full: "World Health Organization",
    href: "https://www.who.int",
  },
];

export default function LandingPage({ onStart }: LandingPageProps) {
  return (
    <div className="min-h-screen flex flex-col">
      {/* Hero */}
      <section className="relative overflow-hidden bg-gradient-to-br from-section-blue via-white to-white pt-20 pb-24 px-4">
        <div
          className="absolute inset-0 opacity-[0.04] pointer-events-none"
          style={{
            backgroundImage:
              "radial-gradient(circle at 30% 20%, oklch(0.55 0.1 216) 0%, transparent 60%), radial-gradient(circle at 80% 80%, oklch(0.43 0.09 218) 0%, transparent 60%)",
          }}
        />
        <div className="max-w-4xl mx-auto text-center relative z-10">
          <motion.h1
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5, delay: 0.1 }}
            className="text-5xl sm:text-6xl font-bold text-foreground tracking-tight mb-4"
          >
            Quick<span className="text-primary">Med</span>
          </motion.h1>
          <motion.p
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5, delay: 0.2 }}
            className="text-xl sm:text-2xl text-muted-foreground font-medium mb-6"
          >
            Safe OTC Guidance, Based on Your Symptoms
          </motion.p>
          <motion.p
            initial={{ opacity: 0, y: 16 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5, delay: 0.3 }}
            className="text-base text-muted-foreground max-w-2xl mx-auto mb-10 leading-relaxed"
          >
            Enter your symptoms, age, and health profile to receive personalized
            over-the-counter medicine guidance — including dosage, precautions,
            and drug interactions.
          </motion.p>
          <motion.div
            initial={{ opacity: 0, scale: 0.96 }}
            animate={{ opacity: 1, scale: 1 }}
            transition={{ duration: 0.4, delay: 0.4 }}
          >
            <Button
              size="lg"
              onClick={onStart}
              data-ocid="landing.primary_button"
              className="text-base px-8 py-6 rounded-xl shadow-card-hover hover:shadow-card-hover transition-all font-semibold"
            >
              <Search className="w-5 h-5 mr-2" />
              Check Your Symptoms
            </Button>
          </motion.div>
        </div>
      </section>

      {/* Disclaimer */}
      <section className="px-4 py-5">
        <div className="max-w-4xl mx-auto">
          <div className="flex items-start gap-3 bg-avoid-bg border border-avoid-text/20 rounded-xl px-5 py-4">
            <AlertTriangle className="w-5 h-5 text-avoid-text mt-0.5 flex-shrink-0" />
            <p className="text-sm text-avoid-text leading-relaxed">
              <strong>Important Disclaimer:</strong> QuickMed is for
              informational and self-care support only. It does not replace
              professional medical advice, diagnosis, or treatment. Consult a
              doctor for severe, persistent, or unclear symptoms.
            </p>
          </div>
        </div>
      </section>

      {/* Features */}
      <section className="px-4 py-16">
        <div className="max-w-4xl mx-auto">
          <h2 className="text-2xl font-bold text-center text-foreground mb-10">
            Everything You Need for Safe Self-Care
          </h2>
          <div className="grid sm:grid-cols-2 gap-5">
            {features.map((f, i) => (
              <motion.div
                key={f.title}
                initial={{ opacity: 0, y: 20 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true }}
                transition={{ duration: 0.4, delay: i * 0.08 }}
                className="bg-card border border-border rounded-xl p-6 shadow-xs hover:shadow-card transition-shadow"
              >
                <div
                  className={`w-11 h-11 rounded-lg ${f.bg} flex items-center justify-center mb-4`}
                >
                  <f.icon className={`w-5 h-5 ${f.color}`} />
                </div>
                <h3 className="font-semibold text-foreground mb-2">
                  {f.title}
                </h3>
                <p className="text-sm text-muted-foreground leading-relaxed">
                  {f.desc}
                </p>
              </motion.div>
            ))}
          </div>
        </div>
      </section>

      {/* How it works */}
      <section className="px-4 py-12 bg-section-blue">
        <div className="max-w-4xl mx-auto">
          <h2 className="text-2xl font-bold text-center text-foreground mb-10">
            How It Works
          </h2>
          <div className="grid sm:grid-cols-3 gap-6">
            {[
              {
                step: "1",
                title: "Enter Symptoms",
                desc: "Select symptoms and share your health profile",
              },
              {
                step: "2",
                title: "Smart Matching",
                desc: "System filters medicines by age, allergy & pregnancy status",
              },
              {
                step: "3",
                title: "Get Safe Guidance",
                desc: "Review OTC options with dosage, warnings & interactions",
              },
            ].map((item) => (
              <div key={item.step} className="text-center">
                <div className="w-12 h-12 rounded-full bg-primary text-primary-foreground flex items-center justify-center font-bold text-lg mx-auto mb-3">
                  {item.step}
                </div>
                <h3 className="font-semibold text-foreground mb-1">
                  {item.title}
                </h3>
                <p className="text-sm text-muted-foreground">{item.desc}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Data Sources */}
      <section className="px-4 py-12">
        <div className="max-w-4xl mx-auto">
          <h2 className="text-lg font-semibold text-center text-muted-foreground mb-6">
            Powered by Trusted Medical Sources
          </h2>
          <div className="flex flex-wrap justify-center gap-4">
            {sources.map((s) => (
              <a
                key={s.name}
                href={s.href}
                target="_blank"
                rel="noopener noreferrer"
                className="flex items-center gap-2 px-5 py-3 bg-card border border-border rounded-xl text-sm hover:border-primary hover:shadow-xs transition-all group"
              >
                <Pill className="w-4 h-4 text-primary" />
                <div>
                  <div className="font-semibold text-foreground">{s.name}</div>
                  <div className="text-xs text-muted-foreground">{s.full}</div>
                </div>
                <ExternalLink className="w-3 h-3 text-muted-foreground group-hover:text-primary ml-1" />
              </a>
            ))}
          </div>
        </div>
      </section>

      {/* Footer */}
      <footer className="mt-auto px-4 py-6 border-t border-border">
        <div className="max-w-4xl mx-auto text-center">
          <p className="text-xs text-muted-foreground">
            © {new Date().getFullYear()} QuickMed. Strictly OTC medicines only.
            Always consult a healthcare professional. Built with ❤️ using{" "}
            <a
              href={`https://caffeine.ai?utm_source=caffeine-footer&utm_medium=referral&utm_content=${encodeURIComponent(window.location.hostname)}`}
              target="_blank"
              rel="noopener noreferrer"
              className="underline hover:text-primary"
            >
              caffeine.ai
            </a>
          </p>
        </div>
      </footer>
    </div>
  );
}
