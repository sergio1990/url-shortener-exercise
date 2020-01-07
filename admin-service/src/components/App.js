import React from 'react';
import AddLinkForm from './AddLinkForm';
import LinksTable from './LinksTable';
import LinksProvider from './LinksContext/Provider';

function App() {
  return (
    <LinksProvider>
      <AddLinkForm />
      <LinksTable />
    </LinksProvider>
  );
}

export default App;
