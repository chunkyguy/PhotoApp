import { useCallback, useState } from "react";
import { Home } from "./screens/Home";
import { Details } from "./screens/Details";
import { useBackHandler } from "./platform/useBackHandler";

// Minimal state-based navigation: no router, so the same code runs on web and native.
// Imports are extensionless so Metro can pick up `.native.js` variants.
export function App() {
  const [selectedId, setSelectedId] = useState(null);

  useBackHandler(
    useCallback(() => {
      if (selectedId == null) return false;
      setSelectedId(null);
      return true;
    }, [selectedId])
  );

  if (selectedId != null) {
    return <Details id={selectedId} onBack={() => setSelectedId(null)} />;
  }
  return <Home onSelect={setSelectedId} />;
}
