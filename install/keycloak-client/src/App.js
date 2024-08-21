import React, { useState } from 'react';
import './App.css';
import "primereact/resources/themes/lara-light-indigo/theme.css";
import "primereact/resources/primereact.min.css";
import '/node_modules/primeflex/primeflex.css'
import { Button } from 'primereact/button';
import { Card } from 'primereact/card';
import Keycloak from 'keycloak-js';

const OAUTH_ENDPOINT = process.env.REACT_APP_OAUTH_ENDPOINT || 'https://oauth.abelardopalma.com/';
const ROOT_ADDRESS = window.location.origin;

let initOptions = {
  url: OAUTH_ENDPOINT,
  realm: 'csa',
  clientId: 'webauth',
  onLoad: 'check-sso', // check-sso | login-required
  KeycloakResponseType: 'code',
  // silentCheckSsoRedirectUri: (window.location.origin + "/silent-check-sso.html")
}

console.log(initOptions);
console.log(ROOT_ADDRESS);

let kc = new Keycloak(initOptions);

kc.init({
  onLoad: initOptions.onLoad,
  KeycloakResponseType: 'code',
  silentCheckSsoRedirectUri: window.location.origin + "/silent-check-sso.html", checkLoginIframe: false,
  pkceMethod: 'S256'
}).then((auth) => {
  if (!auth) {
    window.location.reload();
  } else {
    console.info("Authenticated");
    console.log('auth', auth)
    console.log('Keycloak', kc)
    kc.onTokenExpired = () => {
      console.log('token expired')
    }
  }
}, () => {
  console.error("Authenticated Failed");
});

function App() {

  const [infoMessage, setInfoMessage] = useState('');

  return (
    <div className="App">
      {/* <Auth /> */}
      <div className='grid'>
        <div className='col-12'>
          <h1>Keycloak with React</h1>
        </div>
        <div className='col-12'>
          <h1 id='app-header-2'>{kc.authenticated?"Secured with Keycloak [" + kc.tokenParsed.preferred_username + "]":"Not logged" }</h1>
          <h1 id='app-header-2'></h1>
        </div>
      </div>
      <div className="grid">
        <div className="col">
          <Button onClick={() => { setInfoMessage(kc.authenticated ? 'Authenticated: TRUE' : 'Authenticated: FALSE') }} className="m-1" label='Is Authenticated' />
          <Button onClick={() => { kc.login() }} className='m-1' label='Login' />
          <Button onClick={() => { setInfoMessage(kc.token) }} className="m-1" label='Show Access Token' />
          <Button onClick={() => { setInfoMessage(JSON.stringify(kc.tokenParsed, null, 2)) }} className="m-1" label='Show Parsed Access token' />
          <Button onClick={() => { setInfoMessage(kc.isTokenExpired(5).toString()) }} className="m-1" label='Check Token expired'  />          
          <Button onClick={() => { kc.logout({ redirectUri: ROOT_ADDRESS }) }} className="m-1" label='Logout' />
          
        </div>
      </div>

      <div className='grid'>
      <div className='col'>
        <h2>Is authenticated: {kc.authenticated}</h2>
      </div>
        </div> 


      <div className='grid'>
        <div className='col-2'></div>
        <div className='col-8'>
        <h3>Info Pane</h3>
          <Card>
            <p style={{ wordBreak: 'break-all' }} id='infoPanel'>
              {infoMessage}
            </p>
          </Card>
        </div>
        <div className='col-2'></div>
      </div>



    </div>
  );
}


export default App;
