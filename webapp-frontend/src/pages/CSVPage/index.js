import React, { useEffect, useState } from "react";
import ReactDOM from "react-dom";
import CSVReader from "react-csv-reader";
import "./styles.css";
import CSVTable from "../../components/CSVTable";
import { v4 as uuidv4 } from "uuid";
import _ from "lodash";
import { Button, Icon, Container } from "@material-ui/core";
import Dropdown from "../../components/Dropdown";
import Papa from "papaparse";
import FileCycler from "../../components/FileCycler";
import { useUploadFiles } from "../../hooks/UploadProgress";
import Loading from "../../components/Loading";
import { useSnackbar } from "notistack";

const papaparseOptions = {
  header: true,
  dynamicTyping: true,
  skipEmptyLines: true,
  transformHeader: (header) => header.toLowerCase().replace(/\W/g, "_"),
};

const CSVPage = () => {
  const { enqueueSnackbar } = useSnackbar();
  const [csvsState, setCsvsState] = useState([]);
  const [csvIndx, setCsvIndx] = React.useState(1);
  const [uploadFiles, loading, error] = useUploadFiles();
  const handleAttachFile = (e) => {
    // could do some validation for the attached file here, for example on size
    try {
      const files = e.target.files;
      let newState = [...csvsState];
      for (let i = 0; i < files.length; i++) {
        const id = uuidv4();
        newState = [
          ...newState,
          {
            id,
            file: files[i],
            progress: 0,
          },
        ];
      }
      setCsvsState(newState);
    } catch (e) {
      console.log(e);
    }
    e.target.value = ""; // to clear the current file
  };
  const handleChange = async (event, value) => {
    setCsvIndx(value);
  };

  const handleSubmission = async () => {
    try {
      await uploadFiles(csvsState);
      enqueueSnackbar("Upload of files succeeded!", {
        variant: "success",
      });
    } catch (e) {
      enqueueSnackbar("Upload of files failed, try again.", {
        variant: "error",
      });
    }
  };

  useEffect(() => {
    if (csvsState.length > 0 && !csvsState[csvIndx - 1]?.csv) {
      Papa.parse(csvsState[csvIndx - 1].file, {
        ...papaparseOptions,
        complete: function (results, file) {
          const newCsvState = [...csvsState];
          newCsvState[csvIndx - 1] = {
            ...csvsState[csvIndx - 1],
            csv: results.data,
          };
          setCsvsState(newCsvState);
        },
      });
    }
  }, [csvIndx, setCsvsState, csvsState, setCsvIndx]);

  return (
    <Container style={{ display: "flex", flexDirection: "column" }}>
      <h1 style={{ textAlign: "center" }}>Audits</h1>
      <input
        type="file"
        id="input"
        multiple
        onChange={handleAttachFile}
        accept=".csv"
      />

      {csvsState.length > 0 ? (
        <FileCycler
          handleChange={handleChange}
          csvs={csvsState}
          csvIndx={csvIndx}
        />
      ) : (
        <h4 style={{ textAlign: "center" }}>No csvs selected</h4>
      )}
      {/* <div>
        <span>
          <Dropdown />
          <Dropdown />
          <Dropdown />
          <Dropdown />
          <Dropdown />
        </span>
      </div> */}
      <CSVTable csv={csvsState[csvIndx - 1]?.csv || []} />
      <Button
        variant="contained"
        color="primary"
        style={{ marginTop: "1rem" }}
        endIcon={<Icon>send</Icon>}
        onClick={handleSubmission}
      >
        Send
      </Button>
      {console.log(error)}
      {loading && !error && <Loading />}
    </Container>
  );
};

export default CSVPage;
