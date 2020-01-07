import React, { useContext } from 'react';
import Row from './Row';
import { context } from '../LinksContext';

function Rows() {
  const data = useContext(context);

  const renderedUrls = data === null ? null : data.map(link => <Row key={ link.full_url } {...link} /> )
  return (
    <tbody>
      { renderedUrls }
    </tbody>
  );
}

export default Rows;
