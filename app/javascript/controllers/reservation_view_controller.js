import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reservation-view"
export default class extends Controller {
  connect() {
    let collapseReservation = document.querySelectorAll(".masterclass_reservation--hidden");
    let showMore = document.querySelectorAll(".showMore");

    for (let index = 0; index < collapseReservation.length; index++) {
      let button = showMore.item(index)

      button.addEventListener('click', function(){
        collapseReservation.item(index).classList.toggle('masterclass_reservation--visible')
        collapseReservation.item(index).classList.toggle('masterclass_reservation--hidden')
      })
    }
  }
}
