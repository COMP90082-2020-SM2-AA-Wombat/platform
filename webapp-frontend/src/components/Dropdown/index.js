import React from "react";
import { makeStyles } from "@material-ui/core/styles";
import InputLabel from "@material-ui/core/InputLabel";
import FormHelperText from "@material-ui/core/FormHelperText";
import FormControl from "@material-ui/core/FormControl";
import Select from "@material-ui/core/Select";
import NativeSelect from "@material-ui/core/NativeSelect";

const useStyles = makeStyles((theme) => ({
  formControl: {
    margin: theme.spacing(1),
    minWidth: 120,
  },
  selectEmpty: {
    marginTop: theme.spacing(2),
  },
}));

export default function Dropdown({ options, value }) {
  const classes = useStyles();
  const [state, setState] = React.useState({
    auditor: "",
  });

  const handleChange = (event) => {
    const name = event.target.name;
    setState({
      ...state,
      [name]: event.target.value,
    });
  };

  return (
    <FormControl required className={classes.formControl}>
      <InputLabel htmlFor="age-native-required">Auditor</InputLabel>
      <Select
        native
        value={state.auditor}
        onChange={handleChange}
        name="auditor"
        inputProps={{
          id: "auditor-required",
        }}
      >
        <option aria-label="None" value="" />
        <option value={1}>Micheal Scott</option>
        <option value={2}>Sabeena Beveridge </option>
        <option value={3}>Andrew Alves</option>
      </Select>
      <FormHelperText>Required</FormHelperText>
    </FormControl>
  );
}
