const scriptURL ='https://script.google.com/macros/s/AKfycbx63pslOf_8_h32rbMhG0wknWA00kjLS_-enkSiesOhO2ewPK2aS2YWrY8s1RyBwIRV/exec'

const form = document.forms['form2-2']

form.addEventListener('submit', e => {
    e.preventDefault()
    fetch(scriptURL, {method: 'POST', body: new FormData(form)})
    .then(Response => alert("Cargado"))
    .then(() => {window.location.reload(); })
    .catch(error => console.error('Error!', error.message))
})