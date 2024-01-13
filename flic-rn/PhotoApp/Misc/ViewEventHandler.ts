
export interface ViewEvent {}

export interface ViewEventHandler {
  handleEvent: (event: ViewEvent) => void;
}
