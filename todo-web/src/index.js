import React, { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import App from "./App";
import { AuthProvider } from "react-oidc-context";
import { UserManager, WebStorageStateStore } from "oidc-client-ts";

import axios from "axios";

const root = createRoot(document.getElementById("root"));

const onSigninCallback = (_user) => {
  axios.interceptors.request.use((config) => {
    config.headers["Authorization"] = `Bearer ${_user.id_token}`;
    return config;
  });
  window.history.replaceState(
    {},
    document.title,
    window.location.pathname
  )
}

const oidcConfig = {
  authority: "https://id.jobico.org/",
  client_id: "277676994190180632@jobico",
  redirect_uri: "http://localhost:3000",
  onSigninCallback,
  scope: "openid email urn:zitadel:iam:user:metadata",
  userStore: new WebStorageStateStore({ store: window.localStorage }),
  post_logout_redirect_uri: 'http://localhost:3000/',

};

root.render(
  <AuthProvider {...oidcConfig}>
    <StrictMode>
      <App />
    </StrictMode>
    </AuthProvider>
);
