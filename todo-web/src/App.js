import React, { useState } from "react";
import MainPanel from "./components/MainPanel";
import SideMenu from "./components/SideMenu";
import TopBar from "./components/TopBar";
import LoadingSpinner from "./common/Spinner";
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

  //if (auth.isAuthenticated) {
    return (
      <>
        <TopBar toggleMenu={toggleMenu} menuShown={menuShown} />

        <SideMenu menuShown={menuShown} />

        <MainPanel />
      </>
    );
  //}
  //return <button onClick={() => void auth.signinRedirect()}>Log in</button>;
}
