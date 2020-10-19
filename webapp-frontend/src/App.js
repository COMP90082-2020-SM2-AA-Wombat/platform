import React from "react";
import "./App.css";
import CSVPage from "./pages/CSVPage";
import NavBar from "./components/NavBar";
import { SnackbarProvider } from "notistack";
import { BrowserRouter, Route, Switch, Redirect } from "react-router-dom";
import InsertionPage from "./pages/InsertionPage";

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
      <BrowserRouter>
        <div
          style={{
            textAlign: "center",
            display: "flex",
            flexDirection: "column",
            alignItems: true,
          }}
        >
          <h1>Audits</h1>
          <NavBar style={{ width: "auto" }} />
        </div>
        <Switch>
          <Route exact path="/csv">
            <CSVPage />
          </Route>
          <Route exact path="/insertions">
            <InsertionPage />
          </Route>
          <Route path="/">
            <Redirect to="/csv" />
          </Route>
        </Switch>
      </BrowserRouter>
    </SnackbarProvider>
  );
}

export default App;
