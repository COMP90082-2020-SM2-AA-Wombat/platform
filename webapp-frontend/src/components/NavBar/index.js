import React from "react";
import { Link, useLocation } from "react-router-dom";
import useStyles from "./styles";

import BottomNavigation from "@material-ui/core/BottomNavigation";
import BottomNavigationAction from "@material-ui/core/BottomNavigationAction";
import AssessmentIcon from "@material-ui/icons/Assessment";
import AddIcon from "@material-ui/icons/Add";

export default function NavBar() {
  const location = useLocation();
  const classes = useStyles();

  return (
    <BottomNavigation value={location.pathname.split("/")[1]} className={classes.navigation}>
      <BottomNavigationAction
        label="CSV"
        value="csv"
        icon={<AssessmentIcon />}
        component={Link}
        to="/csv"
      />
      <BottomNavigationAction
        label="Insertions"
        value="insertions"
        icon={<AddIcon />}
        component={Link}
        to="/insertions"
      />
    </BottomNavigation>
  );
}
