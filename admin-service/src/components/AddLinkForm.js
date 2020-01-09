import React, { useContext, useState } from 'react';
import { context } from './LinksContext';
import shortenerAPIClient from 'utils/shortener-api';

function AddLinkForm() {
  const { reload } = useContext(context);
  const [isBadgeShown, setIsBadgeShown] = useState(false);

  let longUrlField = null;

  const handleSubmit = (event) => {
    event.preventDefault();
    const longUrl = longUrlField.value;
    shortenerAPIClient.shortenLink(longUrl).then(_data => {
      longUrlField.value = null;
      reload();
      setIsBadgeShown(true);
      setTimeout(() => setIsBadgeShown(false), 1500);
    });
  };

  return (
    <form className="form-inline" onSubmit={ handleSubmit }>
      <label className="sr-only" htmlFor="long-url">Long URL</label>
      <input type="text" className="form-control mb-2 mr-sm-2 w-50" id="long-url" placeholder="Long URL" ref={ node => longUrlField = node }/>
      <button type="submit" className="btn btn-primary mb-2">Shorten URL</button>
      { isBadgeShown && (<span className="ml-2 badge badge-success">shortened successfully</span>)}
    </form>
  );
}

export default AddLinkForm;
