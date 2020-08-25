const resetTransition = () => {
    const container = document.getElementById('flash-messages')
    container.classList.remove('translate-animation')
    setTimeout(()=>{
        container.classList.add('translate-animation')
    })
}

const createFlashMessage = (type, message) => {
    const container = document.getElementById('flash-messages')
    if(!container) return
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