export default {
    notice: (content) => {
        const notice =  document.createElement('div')
        notice.classList.add('flash-message', 'notice')
        notice.innerHTML = content
        document.getElementById('flash-messages').appendChild(notice)
    }
}