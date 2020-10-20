import React from "react";
import logo from "./logo.svg";
import "./App.css";
import CSVPage from "./pages/CSVPage";
import { SnackbarProvider } from "notistack";

const styles = {
  success: { backgroundColor: "purple" },
  error: { backgroundColor: "blue" },
  warning: { backgroundColor: "green" },
  info: { backgroundColor: "yellow" },
};

function App() {
  return (
    <SnackbarProvider
      classes={{
        variantSuccess: styles.success.backgroundColor,
        variantError: styles.error.backgroundColor,
        variantWarning: styles.warning.backgroundColor,
        variantInfo: styles.info.backgroundColor,
      }}
      maxSnack={3}
    >
      <CSVPage />
    </SnackbarProvider>
  );
}

export default App;
