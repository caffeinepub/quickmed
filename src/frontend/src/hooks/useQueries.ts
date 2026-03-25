import { useMutation, useQuery } from "@tanstack/react-query";
import type { Interaction, OTCMedicine } from "../backend.d";
import { useActor } from "./useActor";

export function useGetAllSymptoms() {
  const { actor, isFetching } = useActor();
  return useQuery<string[]>({
    queryKey: ["symptoms"],
    queryFn: async () => {
      if (!actor) return [];
      return actor.getAllSymptoms();
    },
    enabled: !!actor && !isFetching,
  });
}

export function useGetRecommendations() {
  const { actor } = useActor();
  return useMutation<
    OTCMedicine[],
    Error,
    {
      symptoms: string[];
      age: number;
      pregnancyStatus: string;
      allergies: string[];
    }
  >({
    mutationFn: async ({ symptoms, age, pregnancyStatus, allergies }) => {
      if (!actor) throw new Error("Actor not ready");
      return actor.getRecommendations(
        symptoms,
        BigInt(age),
        pregnancyStatus,
        allergies,
      );
    },
  });
}

export function useCheckInteractions() {
  const { actor } = useActor();
  return useMutation<Interaction[], Error, string[]>({
    mutationFn: async (drugs: string[]) => {
      if (!actor) throw new Error("Actor not ready");
      return actor.checkInteractions(drugs);
    },
  });
}
