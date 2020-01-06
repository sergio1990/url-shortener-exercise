import React from 'react';

function Row(props) {
  const { full_url, short_prefix } = props;
  return (
    <tr>
      <td>{ full_url }</td>
      <td>{ short_prefix }</td>
      <td>actions...</td>
    </tr>
  );
}

export default Row;
