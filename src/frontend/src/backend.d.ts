import type { Principal } from "@icp-sdk/core/principal";
export interface Some<T> {
    __kind__: "Some";
    value: T;
}
export interface None {
    __kind__: "None";
}
export type Option<T> = Some<T> | None;
export interface OTCMedicine {
    name: string;
    minAge: bigint;
    allergyNotes: Array<string>;
    warnings: string;
    safetyLevel: SafetyLevel;
    pregnancySafe?: boolean;
    symptoms: Array<string>;
    brandName: string;
    dosageInstructions: string;
}
export enum SafetyLevel {
    avoid = "avoid",
    safe = "safe",
    caution = "caution"
}
export interface backendInterface {
    getAllMedicines(): Promise<Array<OTCMedicine>>;
    getAllSymptoms(): Promise<Array<string>>;
    getRecommendations(symptoms: Array<string>, age: bigint, pregnancyStatus: string, allergies: Array<string>): Promise<Array<OTCMedicine>>;
}
