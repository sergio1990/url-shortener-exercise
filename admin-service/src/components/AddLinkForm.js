import React, { useContext, useState } from 'react';
import { context } from './LinksContext';
import shortenerAPIClient from 'utils/shortener-api';

function AddLinkForm() {
  const { reload } = useContext(context);
  const [isBadgeShown, setIsBadgeShown] = useState(false);
  const [isFullUrlFieldInvalid, setFullUrlFieldInvalidState] = useState(false);

  let longUrlField = null;

  const handleSubmit = (event) => {
    event.preventDefault();
    const longUrl = longUrlField.value;
    if (longUrl === "") {
      setFullUrlFieldInvalidState(true);
      return;
    }

    shortenerAPIClient.shortenLink(longUrl).then(_data => {
      longUrlField.value = null;
      reload();
      setIsBadgeShown(true);
      setTimeout(() => setIsBadgeShown(false), 1500);
      if (isFullUrlFieldInvalid) { setFullUrlFieldInvalidState(false); }
    });
  };

  let fullUrlFieldClasses = ["form-control", "mb-2", "mr-sm-2", "w-100"];
  if (isFullUrlFieldInvalid) {
    fullUrlFieldClasses.push("is-invalid");
  }

  return (
    <form className="mb-4" onSubmit={ handleSubmit }>
      <div className="form-row">
        <div className="col-md-12 mb-2">
          <label className="sr-only" htmlFor="long-url">Long URL</label>
          <input type="text" className={ fullUrlFieldClasses.join(' ') } id="long-url" placeholder="Long URL" ref={ node => longUrlField = node }/>
          <div className="invalid-feedback">
            Please, fill in a full URL to shorten it!
          </div>
        </div>
      </div>
      <button type="submit" className="btn btn-primary mb-2">Shorten URL</button>
      { isBadgeShown && (<span className="ml-2 badge badge-success">shortened successfully</span>)}
    </form>
  );
}

export default AddLinkForm;
