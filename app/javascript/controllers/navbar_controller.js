import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  connect() {
    let collapseButton = document.querySelector(".profile_menu > button:nth-child(1)");
    let collapseNavbar = document.querySelector(".navbar");
    let collapseSecondnav = document.querySelector(".secondnav");

    let collapse_menu = document.querySelector(".collapse_menu");
    let main = document.querySelector("main");
    let collapseVideo = document.querySelector(".video_banner")
    console.log(collapseVideo)

    collapseButton.addEventListener("click", function () {
      collapse_profile.classList.toggle("collapse_profile--active");
    });

    collapseButtonOnMenu.addEventListener("click", function () {
      collapse_menu.classList.toggle("collapse_menu--active");
      main.classList.toggle("main--blur");
    });

    search_button.addEventListener("click", function () {
      collapseNavbar.classList.toggle("navbar--collapse");
      collapseSecondnav.classList.toggle("secondnav--collapse");
      collapseVideo.classList.toggle("video--collapse");
    });
    window.addEventListener("click", function (e) {
      if (
        e.target.localName !== "img" &&
        e.target.localName !== "i" &&
        e.target.id !== "collapse_profile"
      ) {
        collapse_profile.classList.remove("collapse_profile--active");
      }
      if (e.target.id !== "search_button" && e.target.id !== "search") {
        collapseNavbar.classList.remove("navbar--collapse");
      }
      if (
        e.target.id !== "collapseButtonOnMenu" && e.target.className !== "collapse_menu"
      ) {
        collapse_menu.classList.remove("collapse_menu--active");
        main.classList.remove("main--blur");
      }
    });
  }
}