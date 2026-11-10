import { useState } from "react";
import { Home } from "./screens/Home.jsx";
import { Details } from "./screens/Details.jsx";

// Minimal state-based navigation: no router, so the same code can run on native.
export function App() {
  const [selectedId, setSelectedId] = useState(null);

  if (selectedId != null) {
    return <Details id={selectedId} onBack={() => setSelectedId(null)} />;
  }
  return <Home onSelect={setSelectedId} />;
}
