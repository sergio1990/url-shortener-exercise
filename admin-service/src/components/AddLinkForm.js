import React from 'react';

function AddLinkForm() {
  return (
    <form className="form-inline">
      <label className="sr-only" for="long-url">Long URL</label>
      <input type="text" className="form-control mb-2 mr-sm-2 w-50" id="long-url" placeholder="Long URL"/>
      <button type="submit" className="btn btn-primary mb-2">Shorten URL</button>
    </form>
  );
}

export default AddLinkForm;
