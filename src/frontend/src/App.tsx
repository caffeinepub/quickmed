import { Toaster } from "@/components/ui/sonner";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { AnimatePresence, motion } from "motion/react";
import { useState } from "react";
import type { OTCMedicine } from "./backend.d";
import InteractionCheckerPage from "./pages/InteractionCheckerPage";
import LandingPage from "./pages/LandingPage";
import ResultsPage from "./pages/ResultsPage";
import SymptomFormPage from "./pages/SymptomFormPage";
import type { FormData } from "./pages/SymptomFormPage";

type Page = "landing" | "form" | "results" | "interactions";

const queryClient = new QueryClient();

function PageWrapper({
  children,
  pageKey,
}: { children: React.ReactNode; pageKey: string }) {
  return (
    <motion.div
      key={pageKey}
      initial={{ opacity: 0, x: 20 }}
      animate={{ opacity: 1, x: 0 }}
      exit={{ opacity: 0, x: -20 }}
      transition={{ duration: 0.3, ease: "easeInOut" }}
      className="w-full"
    >
      {children}
    </motion.div>
  );
}

function AppContent() {
  const [page, setPage] = useState<Page>("landing");
  const [medicines, setMedicines] = useState<OTCMedicine[]>([]);
  const [formData, setFormData] = useState<FormData>({
    symptoms: [],
    age: 0,
    gender: "",
    pregnancyStatus: "not_pregnant",
    allergies: [],
  });

  const handleResults = (newMedicines: OTCMedicine[], fd: FormData) => {
    setMedicines(newMedicines);
    setFormData(fd);
    setPage("results");
  };

  return (
    <div className="min-h-screen bg-background">
      <AnimatePresence mode="wait">
        {page === "landing" && (
          <PageWrapper pageKey="landing">
            <LandingPage onStart={() => setPage("form")} />
          </PageWrapper>
        )}
        {page === "form" && (
          <PageWrapper pageKey="form">
            <SymptomFormPage
              onBack={() => setPage("landing")}
              onResults={handleResults}
            />
          </PageWrapper>
        )}
        {page === "results" && (
          <PageWrapper pageKey="results">
            <ResultsPage
              medicines={medicines}
              formData={formData}
              onBack={() => setPage("form")}
              onCheckInteractions={() => setPage("interactions")}
            />
          </PageWrapper>
        )}
        {page === "interactions" && (
          <PageWrapper pageKey="interactions">
            <InteractionCheckerPage
              initialMedicines={medicines}
              onBack={() => setPage("results")}
            />
          </PageWrapper>
        )}
      </AnimatePresence>
      <Toaster />
    </div>
  );
}

export default function App() {
  return (
    <QueryClientProvider client={queryClient}>
      <AppContent />
    </QueryClientProvider>
  );
}
