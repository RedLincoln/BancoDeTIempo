const createFlashMessage = (type, message) => {
    const container = document.getElementById('flash-messages')
    container.innerHTML = ""
    const flash =  document.createElement('div')
    flash.classList.add('flash-message', type)
    flash.innerHTML = message
    container.appendChild(flash)
}

export default {
    notice: (message) => {
        createFlashMessage('notice', message)
    },

    alert: (message) => {
        createFlashMessage('alert', message)
    },

}