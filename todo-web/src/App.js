import React, { useState } from "react";
import MainPanel from "./components/MainPanel";
import SideMenu from "./components/SideMenu";
import TopBar from "./components/TopBar";
import axios from "axios";
import { useAuth, hasAuthParams } from "react-oidc-context";


export default function TODOApp() {
  const auth = useAuth();
  const [menuShown, toggleMenu] = useState(false);
  const [hasTriedSignin, setHasTriedSignin] = React.useState(false);

  React.useEffect(() => {
    if (!hasAuthParams() &&
      !auth.isAuthenticated && !auth.activeNavigator && !auth.isLoading &&
      !hasTriedSignin
    ) {
      auth.signinRedirect();
      setHasTriedSignin(true);
    }
  }, [auth, hasTriedSignin]);

  switch (auth.activeNavigator) {
    case "signinSilent":
      return <div>Signing you in...</div>;
    case "signoutRedirect":
      return <div>Signing you out...</div>;
  }

  if (auth.isLoading) {
    return <div>Loading...</div>;
  }

  if (auth.error) {
    return <div>Oops... {auth.error.message}</div>;
  }
  if (auth.isAuthenticated) {
    const token = auth.user.id_token
    axios.interceptors.request.use((config) => {
      config.headers["Authorization"] = `Bearer ${token}`;
      return config;
    });
  }

  return (
    <>
      <TopBar toggleMenu={toggleMenu} menuShown={menuShown} />

      <SideMenu menuShown={menuShown} />

      <MainPanel />
    </>
  );
}
