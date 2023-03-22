// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

let collapseButton = document.querySelector('.profile_menu > button:nth-child(1)')

collapseButton.addEventListener('click', function(){
  collapse_profile.classList.toggle('collapse_profile--active')
})

window.addEventListener('click', function(e){
  console.log(e.target.id)
  if(e.target.localName !== 'img' && e.target.id !== 'collapse_profile' ){
    collapse_profile.classList.remove('collapse_profile--active')
  }
})