import { ScrollView as RNScrollView } from "react-native";

export function ScrollView({ children }) {
  return (
    <RNScrollView style={{ flex: 1 }} contentContainerStyle={{ flexGrow: 1 }}>
      {children}
    </RNScrollView>
  );
}
