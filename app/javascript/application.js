// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

let collapseReservation = document.querySelectorAll(".masterclass_reservation--hidden");
let showMore = document.querySelectorAll(".showMore");

for (let index = 0; index < collapseReservation.length; index++) {
  let button = showMore.item(index)

  button.addEventListener('click', function(){
    collapseReservation.item(index).classList.toggle('masterclass_reservation--visible')
    collapseReservation.item(index).classList.toggle('masterclass_reservation--hidden')
  })
}