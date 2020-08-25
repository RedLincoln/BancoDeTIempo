const createFlashMessage = (type, message) => {
    const flash =  document.createElement('div')
    flash.classList.add('flash-message', type)
    flash.innerHTML = message
    document.getElementById('flash-messages').appendChild(flash)
}

export default {
    notice: (message) => {
        createFlashMessage('notice', message)
    },

    alert: (message) => {
        createFlashMessage('alert', message)
    },

}