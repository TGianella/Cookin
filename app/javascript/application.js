// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

let collapseButton = document.querySelector(
  ".profile_menu > button:nth-child(1)"
);
let collapseNavbar = document.querySelector(".navbar");
let collapseSecondnav = document.querySelector(".secondnav");

let collapse_menu = document.querySelector(".collapse_menu")
let main = document.querySelector("main")

collapseButton.addEventListener("click", function () {
  collapse_profile.classList.toggle("collapse_profile--active");
});

collapseButtonOnMenu.addEventListener("click", function(){
  console.log(collapseButtonOnMenu)
  collapse_menu.classList.toggle("collapse_menu--active")
  main.classList.toggle("main--blur")
})

search_button.addEventListener("click", function () {
  collapseNavbar.classList.toggle("navbar--collapse");
  collapseSecondnav.classList.toggle("secondnav--collapse");
});
window.addEventListener("click", function (e) {
  if (
    e.target.localName !== "img" &&
    e.target.localName !== "i" &&
    e.target.id !== "collapse_profile"
  ) {
    collapse_profile.classList.remove("collapse_profile--active");
  }
  if (e.target.id !== "search_button" && e.target.id !=="search") {
    collapseNavbar.classList.remove("navbar--collapse");
    collapseSecondnav.classList.remove("secondnav--collapse");
  }
});
