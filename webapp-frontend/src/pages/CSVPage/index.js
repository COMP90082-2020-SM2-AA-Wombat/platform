import React, { useEffect, useState } from "react";
import ReactDOM from "react-dom";
import CSVReader from "react-csv-reader";
import "./styles.css";
import CSVTable from "../../components/CSVTable";
import { Button, Icon } from "@material-ui/core";
const papaparseOptions = {
  header: true,
  dynamicTyping: true,
  skipEmptyLines: true,
  transformHeader: (header) => header.toLowerCase().replace(/\W/g, "_"),
};

const CSVPage = () => {
  const [csvState, setCsvState] = useState([]);
  const handleForce = (data, fileInfo) => {
    setCsvState(data);
    console.log(data, fileInfo);
  };

  return (
    <div style={{ padding: "4rem 1rem 0rem 1rem" }}>
      <CSVReader
        cssClass="react-csv-input"
        label="Select CSV"
        onFileLoaded={handleForce}
        parserOptions={papaparseOptions}
      />
      <Button
        variant="contained"
        color="primary"
        style={{ margin: "1rem" }}
        endIcon={<Icon>send</Icon>}
      >
        Send
      </Button>

      <CSVTable csv={csvState} />
    </div>
  );
};

export default CSVPage;
