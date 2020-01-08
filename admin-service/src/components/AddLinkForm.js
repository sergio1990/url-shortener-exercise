import React from 'react';
import shortenerAPIClient from 'utils/shortener-api';

function AddLinkForm() {
  let longUrlField = null;

  const handleSubmit = (event) => {
    event.preventDefault();
    const longUrl = longUrlField.value;
    shortenerAPIClient.shortenLink(longUrl).then(_data => {
      longUrlField.value = null;
    });
  };

  return (
    <form className="form-inline" onSubmit={ handleSubmit }>
      <label className="sr-only" for="long-url">Long URL</label>
      <input type="text" className="form-control mb-2 mr-sm-2 w-50" id="long-url" placeholder="Long URL" ref={ node => longUrlField = node }/>
      <button type="submit" className="btn btn-primary mb-2">Shorten URL</button>
    </form>
  );
}

export default AddLinkForm;
