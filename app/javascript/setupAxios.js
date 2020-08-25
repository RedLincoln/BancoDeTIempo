import axios from 'axios'

const token = document.querySelector("meta[name=csrf-token]")

const ax = axios.create({
    headers: {
        common: {
            'X-CSRF-Token': token.content
        }
    }
})

export default ax
