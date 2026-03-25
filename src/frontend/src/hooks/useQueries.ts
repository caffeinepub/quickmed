import { useMutation, useQuery } from "@tanstack/react-query";
import type { Interaction, OTCMedicine } from "../backend.d";
import { useActor } from "./useActor";

export function useGetAllSymptoms() {
  const { actor, isFetching: actorFetching } = useActor();
  const query = useQuery<string[]>({
    queryKey: ["symptoms", actor ? "ready" : "waiting"],
    queryFn: async () => {
      if (!actor) throw new Error("Actor not ready");
      const result = await actor.getAllSymptoms();
      return result;
    },
    enabled: !!actor && !actorFetching,
    retry: 3,
    retryDelay: 1000,
  });

  return {
    ...query,
    // isPending stays true when disabled — use isFetching or actorFetching instead
    isPending: query.isFetching || actorFetching,
  };
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
