import React, { useState } from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faCopy as farCopy, faArrowAltCircleRight as farArrowAltCircleRight } from '@fortawesome/free-regular-svg-icons';
import { faCopy as fasCopy, faArrowAltCircleRight as fasArrowAltCircleRight } from '@fortawesome/free-solid-svg-icons';
import config from 'config';
import { copyStringToClipboard } from 'utils/clipboard';

function Row(props) {
  const [data, setData] = useState({ isCopyHover: false, isGoToHover: false });

  const { full_url, short_prefix } = props;
  const short_url = `${config.SHORT_LINK_BASE_URI}${short_prefix}`;

  const onCopyHandler = () => {
    copyStringToClipboard(short_url);
  };

  return (
    <tr>
      <td>
        <a href={ full_url } target="_blank">{ full_url }</a>
      </td>
      <td>
        <a href={ short_url } target="_blank">{ short_url }</a>
      </td>
      <td>
        <FontAwesomeIcon
          icon={ data.isCopyHover ? fasCopy : farCopy }
          size="lg"
          onClick={ onCopyHandler }
          title="Copy the short link"
          onMouseOver={ () => setData({ ...data, isCopyHover: true }) }
          onMouseOut={ () => setData({ ...data, isCopyHover: false }) }/>
        <FontAwesomeIcon
          icon={ data.isGoToHover ? fasArrowAltCircleRight : farArrowAltCircleRight }
          size="lg"
          onMouseOver={ () => setData({ ...data, isGoToHover: true }) }
          onMouseOut={ () => setData({ ...data, isGoToHover: false }) }
          className="ml-2" />
      </td>
    </tr>
  );
}

export default Row;
