export default {
    notice: (content) => {
        const notice =  document.createElement('div')
        notice.classList.add('flash-message', 'notice')
        notice.innerHTML = content
        document.getElementById('flash-messages').appendChild(notice)
    },

    alert: (content) => {
        const alert =  document.createElement('div')
        alert.classList.add('flash-message', 'alert')
        alert.innerHTML = content
        document.getElementById('flash-messages').appendChild(alert)
    },

}