import React from 'react';
import Row from './Row';

const links = [
  {
    full_url: "https://google.com",
    short_prefix: "google"
  }
];

function Rows() {
  const renderedUrls = links.map(link => <Row key={ link.full_url } {...link} /> )
  return (
    <tbody>
      { renderedUrls }
    </tbody>
  );
}

export default Rows;
