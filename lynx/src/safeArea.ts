import { useGlobalProps } from "@lynx-js/react";

export interface Insets {
  top: number;
  bottom: number;
  left: number;
  right: number;
}

// Lynx has no CSS env(safe-area-inset-*). Lynx Explorer instead injects the
// native safe-area insets into globalProps (in px, i.e. iOS points), and
// useGlobalProps re-renders when the host updates them (e.g. on rotation).
//
// The insets can be missing or 0 (other hosts, or before the view is laid out),
// so on iOS fall back to typical values, as Lynx Explorer's own homepage does.
export function useSafeArea(): Insets {
  const props = useGlobalProps();

  const width = Number(props.screenWidth ?? 0);
  const height = Number(props.screenHeight ?? 0);
  const portrait = width > 0 && height > 0 ? height >= width : true;
  const isIOS = SystemInfo.platform === "iOS";
  const notch =
    Boolean(props.isNotchScreen) ||
    Number(props.safeAreaTop ?? 0) > 20 ||
    Number(props.safeAreaBottom ?? 0) > 0;

  const fallbackTop = isIOS && portrait ? (notch ? 54 : 20) : 0;
  const fallbackBottom = isIOS && portrait && notch ? 34 : 0;
  const fallbackSide = isIOS && !portrait ? 54 : 0;

  return {
    top: Math.max(Number(props.safeAreaTop ?? 0), fallbackTop),
    bottom: Math.max(Number(props.safeAreaBottom ?? 0), fallbackBottom),
    left: Math.max(Number(props.safeAreaLeft ?? 0), fallbackSide),
    right: Math.max(Number(props.safeAreaRight ?? 0), fallbackSide),
  };
}
