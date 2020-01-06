import React from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faCopy, faArrowAltCircleRight } from '@fortawesome/free-regular-svg-icons';
import config from 'config';

function Row(props) {
  const { full_url, short_prefix } = props;
  const short_url = `${config.SHORT_LINK_BASE_URI}${short_prefix}`;
  return (
    <tr>
      <td>
        <a href={ full_url } target="_blank">{ full_url }</a>
      </td>
      <td>
        <a href={ short_url } target="_blank">{ short_url }</a>
      </td>
      <td>
        <FontAwesomeIcon icon={ faCopy } size="lg" />
        <FontAwesomeIcon icon={ faArrowAltCircleRight } size="lg" className="ml-2" />
      </td>
    </tr>
  );
}

export default Row;
