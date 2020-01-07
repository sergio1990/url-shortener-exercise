import React from 'react';
import Row from './Row';
import shortenerAPIClient from 'utils/shortener-api';

const links = [
  {
    full_url: "https://google.com",
    short_prefix: "google"
  }
];

function Rows() {
  shortenerAPIClient.allLinks().then(data => console.log(data));

  const renderedUrls = links.map(link => <Row key={ link.full_url } {...link} /> )
  return (
    <tbody>
      { renderedUrls }
    </tbody>
  );
}

export default Rows;
