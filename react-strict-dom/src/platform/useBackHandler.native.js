import { useEffect } from "react";
import { BackHandler } from "react-native";

// Android hardware back button. `onBack` returns true if it handled the press.
export function useBackHandler(onBack) {
  useEffect(() => {
    const sub = BackHandler.addEventListener("hardwareBackPress", onBack);
    return () => sub.remove();
  }, [onBack]);
}
