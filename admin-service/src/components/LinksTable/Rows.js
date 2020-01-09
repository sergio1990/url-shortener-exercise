import React, { useContext } from 'react';
import Row from './Row';
import { context } from '../LinksContext';

function buildInfoRow(message) {
  return (
    <tr>
      <td colSpan="3">
        <div className="alert alert-light" role="alert">
          { message }
        </div>
      </td>
    </tr>
  );
}

function buildTableBody(content) {
  return (
    <tbody>
      { content }
    </tbody>
  );
}

function Rows() {
  const { links } = useContext(context);

  if (links === null) {
    return buildTableBody(buildInfoRow("A links list is being loading..."));
  }
  if (links.length === 0) {
    return buildTableBody(buildInfoRow("There are no links. You can add a new link using the form above."));
  }

  const content = links.map(link => <Row key={ link.full_url } {...link} /> )
  return buildTableBody(content);
}

export default Rows;
