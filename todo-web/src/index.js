import React, { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import App from "./App";
import { AuthProvider } from "react-oidc-context";
import { UserManager, WebStorageStateStore } from "oidc-client-ts";

const root = createRoot(document.getElementById("root"));

const onSigninCallback = (_user) => {
  window.history.replaceState(
    {},
    document.title,
    window.location.pathname
  )
}

const oidcConfig = {
  authority: "https://id.jobico.local/",
  client_id: "285661366109405733",
  redirect_uri: "https://todo.jobico.local",
  onSigninCallback,
  scope: "openid email urn:zitadel:iam:user:metadata",
  userStore: new WebStorageStateStore({ store: window.localStorage }),
  post_logout_redirect_uri: 'https://todo.jobico.local',

};

root.render(
  <AuthProvider {...oidcConfig}>
    <StrictMode>
      <App />
    </StrictMode>
    </AuthProvider>
);
