import React from 'react';
import config from '../../config';

function Row(props) {
  const { full_url, short_prefix } = props;
  const short_url = `${config.SHORT_LINK_BASE_URI}${short_prefix}`;
  return (
    <tr>
      <td>{ full_url }</td>
      <td>{ short_url }</td>
      <td>actions...</td>
    </tr>
  );
}

export default Row;
