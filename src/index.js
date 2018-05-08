import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import registerServiceWorker from './registerServiceWorker';

import Quotes from './Quotes'
import 'bootstrap/dist/css/bootstrap.min.css'

ReactDOM.render(<Quotes />, document.getElementById('root'));
registerServiceWorker();
