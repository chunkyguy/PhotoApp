declare module '@lynx-js/types' {
  // eslint-disable-next-line @typescript-eslint/no-empty-object-type
  interface GlobalProps {
    /**
     * Define your global properties in this interface.
     * These types will be accessible through `lynx.__globalProps`.
     */
    // Injected by Lynx Explorer on iOS, in logical px (iOS points).
    safeAreaTop?: number;
    safeAreaBottom?: number;
    safeAreaLeft?: number;
    safeAreaRight?: number;
    isNotchScreen?: boolean;
    screenWidth?: number;
    screenHeight?: number;
  }
}

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
