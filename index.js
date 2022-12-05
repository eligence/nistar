(function () {
    document.addEventListener('DOMContentLoaded', function(event) {
        document.querySelectorAll('.menu-item').forEach(el => {
            el.addEventListener('click', function(e) {
                if (e.target.classList.contains('menu-item')) {
                    document.querySelector('.active').classList.remove('active')
                    document.querySelector('#menuToggle input').checked = false;
                    document.querySelector(e.target.getAttribute('href')).classList.add('active')
                }
            })
        })
    })
    
  })();