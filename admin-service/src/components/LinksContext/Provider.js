import React, { useState, useEffect } from 'react';
import { context } from './index';
import shortenerAPIClient from 'utils/shortener-api';

function LinksProvider({ children }) {
  const [data, setData] = useState(null);

  useEffect(() =>{
    shortenerAPIClient.allLinks().then(data => {
      setData(data);
    });
  }, []);

  const reload = () => {
    shortenerAPIClient.allLinks().then(data => {
      setData(data);
    });
  };

  const { Provider } = context;
  return(
    <Provider value={{ links: data, reload: reload }}>
      { children }
    </Provider>
  )
}

export default LinksProvider;
