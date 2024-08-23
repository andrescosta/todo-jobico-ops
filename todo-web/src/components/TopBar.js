import React from "react";
import { useAuth } from "react-oidc-context";

export default function TopBar({ toggleMenu, menuShown }) {
  const auth = useAuth();

  function onClickMenu() {
    toggleMenu(!menuShown);
  }

  return (
    <>
      <div className="w3-bar w3-black w3-top w3-large" style={{ zIndex: 4 }}>
        <button
          className="w3-bar-item w3-button w3-hover-none w3-hover-text-light-grey"
          onClick={() => onClickMenu()}
        >
          <i className="fa fa-bars"></i>{" "}
        </button>
        <button
          href="#"
          className="w3-bar-item w3-button w3-right w3-tooltip"
          onClick={() => auth.signoutRedirect()}
          title={"BBye " + auth.user?.profile.email}
        >
          <i className="fa fa-user-circle-o"> </i>{" "}
        </button>
      </div>

      <div
        className="w3-overlay w3-hide-large w3-animate-opacity"
        onClick={() => onClickMenu()}
        style={{ cursor: "pointer" }}
        title="close side menu"
        id="myOverlay"
      ></div>
    </>
  );
}
