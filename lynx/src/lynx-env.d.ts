// Lynx Explorer injects these into globalProps on iOS (in px, i.e. iOS points).
// ReactLynx's useGlobalProps() is typed by its own GlobalProps interface.
declare module '@lynx-js/react' {
  interface GlobalProps {
    safeAreaTop?: number;
    safeAreaBottom?: number;
    safeAreaLeft?: number;
    safeAreaRight?: number;
    isNotchScreen?: boolean;
    screenWidth?: number;
    screenHeight?: number;
  }
}

// This export makes the file a module
export {};
