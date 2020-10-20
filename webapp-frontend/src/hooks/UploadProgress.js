import { useCallback, useState } from "react";
import axios from "axios";

export const useUploadFiles = () => {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(false);

  const uploadFiles = async (files) => {
    console.log("hasd");
    if (files.length) {
      const formPayload = new FormData();
      console.log(files);
      files.forEach((file) => {
        formPayload.append(file.file.name, file.file);
      });
      setLoading(true);
      try {
        const res = await axios({
          baseURL: process.env.REACT_APP_API_DNS,
          url: "/csv",
          method: "post",
          data: formPayload,
        });
        setLoading(false);
        if (res.status >= 400) {
          setError(true);
          throw Error(res.statusText);
        }
        return { data: res.data, status: res.status };
      } catch (e) {
        setError(true);
        throw Error();
      }
    }
  };
  return [uploadFiles, loading, error];
};
