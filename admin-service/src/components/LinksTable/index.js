import React from 'react';
import Header from './Header';
import Rows from './Rows';

function LinksTable() {
  return (
    <table className="table mt-2">
      <Header />
      <Rows />
    </table>
  );
}

export default LinksTable;
