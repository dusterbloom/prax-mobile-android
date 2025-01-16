export type ChangeEventPayload = {
  value: string;
};

export type PenumbraSdkModuleViewProps = {
  name: string;
};

export interface PenumbraSdkModule {
  createAppStateContainer(): Promise<boolean>;
  startServer(): Promise<boolean>;
  getBlockHeight(): Promise<string>; // string because JS can't handle UInt64
}