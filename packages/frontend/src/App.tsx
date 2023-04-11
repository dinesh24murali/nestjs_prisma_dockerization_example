import React, { useEffect } from 'react';
import { OrderStatus, gt, ember } from '@strive/choices';

import logo from './logo.svg';
import './App.css';
import axios from 'axios';

function App() {

  useEffect(() => {
    console.log({
      OrderStatus: OrderStatus.CANCELLED,
      gt11: gt(),
      ember: ember()
    })
    
    axios.get(`${process.env.REACT_APP_BASE_URL}`)
      .then(res => {
        console.log(res.data)
      });
  }, []);

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.tsx</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header>
    </div>
  );
}

export default App;
